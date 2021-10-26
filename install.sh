#!/bin/bash

# --------------------安装一些常用软件--------------------
if [ ${BASE_APP} ]; then
# 安装ctags
echo y|sudo apt-get install ctags
# 安装tree
echo y|sudo apt-get install tree
# 安装htop
echo y|sudo apt-get install htop
# 安装git
echo y|sudo apt-get install git
# 安装ssh
echo y|sudo apt-get install openssh-server
# 安装curl
echo y|sudo apt-get install curl
# 安装wget
echo y|sudo apt-get install wget
# 安装screen
echo y|sudo apt-get install screen
fi
# --------------------------------------------------------


# ------------------------安装c++环境---------------------
if [ ${CPP} ]; then

    cd ${TMP}
    # 安装依赖包
    echo y|sudo apt-get install -y make bzip2 automake libbz2-dev libssl-dev doxygen graphviz libgmp3-dev \
        autotools-dev libicu-dev python2.7 python2.7-dev python3 python3-dev \
        autoconf libtool curl zlib1g-dev sudo ruby libusb-1.0-0-dev \
        libcurl4-gnutls-dev pkg-config patch llvm-7-dev clang-7 vim-common jq

    # 安装gdb
    echo y|sudo apt-get install gdb

    # 安装gcc 8
    sudo apt-get install g++-8
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

    # 安装clang10
    echo y|sudo apt-get install clang-10 libclang-10-dev llvm-10-dev libc++-10-dev libc++abi-10-dev clang-tidy clang-tidy-10
    echo y|sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-10 100 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-10
    clang --version
    clang++ --version
    update-alternatives --display clang

    # 安装cmake-3.19.2
    if [ ! ${CMAKE_DIR} ]; then
        if [ ! -f cmake-3.19.2-Linux-x86_64.sh ];then
	        wget https://github.com/Kitware/CMake/releases/download/v3.19.2/cmake-3.19.2-Linux-x86_64.sh
        fi
        sudo bash cmake-3.19.2-Linux-x86_64.sh --prefix=/usr/local --include-subdir --skip-license

        CMAKE_DIR="/usr/local/cmake-3.19.2-Linux-x86_64"
        export PATH=${CMAKE_DIR}/bin:$PATH
        echo -e '\nCMAKE_DIR=/usr/local/cmake-3.19.2-Linux-x86_64\nexport PATH=${CMAKE_DIR}/bin:$PATH' >> ~/.bashrc
        cmake --version
    fi

    # 安装boost-1.75.0
    if [ ! ${BOOST_ROOT} ]; then
        export BOOST_ROOT="/usr/local/boost-1.75"
        echo -e '\nexport BOOST_ROOT=/usr/local/boost-1.75' >> ~/.bashrc
        sudo mkdir -p ${BOOST_ROOT}
        if [ ! -f boost_1_75_0.tar.bz2 ];then
	        wget -c https://boostorg.jfrog.io/artifactory/main/release/1.75.0/source/boost_1_75_0.tar.bz2
        fi
        tar -xjf boost_1_75_0.tar.bz2
        cd boost_1_75_0
        ./bootstrap.sh --with-toolset=clang --prefix=${BOOST_ROOT}
        sudo ./b2 toolset=clang --without-graph_parallel --without-mpi -q -j $(nproc) install
    fi

fi
# --------------------------------------------------------


# -------------------------安装go环境---------------------
if [ ${GO} ]; then

    cd ${TMP}
    # 下载二进制文件
    if [ ! -f go1.17.2.linux-amd64.tar.gz ]; then
        wget -c https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
    fi
    if [ ! -d go1.17.2.linux-amd64 ]; then
        tar -zxvf go1.17.2.linux-amd64.tar.gz
    fi
    if [ -d /usr/local/go ]; then
        sudo mv /usr/local/go /usr/local/go.bak
    fi
    sudo mv go /usr/local/

    # 配置
    if [ !${GOROOT} ]; then
        echo -e '\nexport GOROOT=/usr/local/go \nexport GOPATH=$HOME/go \nexport GOBIN=$GOPATH/bin \nexport PATH=$GOPATH:$GOBIN:$GOROOT/bin:$PATH' >> ~/.bashrc
    fi

    # 启用
    source ~/.bashrc
    go env

fi
# --------------------------------------------------------


# ---------------------安装vim----------------------------
if [ ${VIM} == "y" ]; then

    cd ${TMP}
    # 安装依赖库
    echo y|sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
        python3-dev ruby-dev lua5.1 lua5.1-dev git

    # 删除原有vim
    dpkg -l|grep vim
    echo y|sudo dpkg -P vim

    # 拉取vim项目
    if [ ! -d "${TMP}/vim" ]; then
    git clone https://github.com/vim/vim.git
    fi
    cd vim

    # 编译安装
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp \
                --enable-python3interp \
                --with-python-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
                --enable-perlinterp \
                --enable-luainterp \
                --enable-gui=gtk2 --enable-cscope --prefix=/usr
    make VIMRUNTIMEDIR=/usr/share/vim/vim80
    sudo make install

    # 设置默认编辑器
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
    sudo update-alternatives --set editor /usr/bin/vim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
    sudo update-alternatives --set vi /usr/bin/vim

     修复一个bug
    if [ -d /usr/share/vim ]; then
    cd /usr/share/vim
        if [ -d vim82 ]; then
            if [ -d vim80 ]; then
                sudo mv vim80 vim80.bak
            fi
            sudo mv vim82 vim80
        fi
    fi

fi
# --------------------------------------------------------



