#!/bin/bash

# 配置环境 
export ARCH=amd64 # CPU架构(amd64/arm64...)
export OS=linux   # 操作系统(linux/macosx/windows)

# 创建临时环境
export TMP=~/tmp
if [ -d ${TMP} ]; then
    sudo rm -rf ${TMP}
fi
mkdir -p ${TMP}

# ---------------------------------------------------
export BASE_APP=y # 安装基本软件
export CLASH=y    # 安装clash(翻墙工具)

# --------------------基本配置 --------------------------
export CFG_SSH_SERV=y # 配置ssh服务器
export CFG_GIT=y      # 配置git
export CFG_GOPROXY=y  # 配置go的国内代理

# -------------------------------------------------------

# -----------------------基本配置 -----------------------
export CTAGS_CFG=y    # 配置ctags
export CTAGS_FILE_URL="https://raw.githubusercontent.com/hanjingo/reborn/main/.ctags " # ctags文件地址

export ALIAS_CFG=y  # 配置别名
export ALIAS_FILE_URL="https://raw.githubusercontent.com/hanjingo/reborn/main/.aliases" # alias文件地址

# -------------------------------------------------------

# -----------------------CPP ----------------------------
export CPP=y      # 安装c++环境

if [ ${CPP} ]; then
    # 配置cmake
    export CMAKE_FILE="cmake-3.19.2-Linux-x86_64.sh"
    export CMAKE_FILE_URL="https://github.com/Kitware/CMake/releases/download/v3.19.2/cmake-3.19.2-Linux-x86_64.sh"
    export CMAKE_VERSION="cmake-3.19.2-Linux-x86_64"
    export CMAKE_DIR="/usr/local/cmake-3.19.2-Linux-x86_64"

    # 配置boost
    export BOOST_FILE="boost_1_75_0.tar.bz2"
    export BOOST_VERSION="boost_1_75_0"
    export BOOST_FILE_URL="https://boostorg.jfrog.io/artifactory/main/release/1.75.0/source/boost_1_75_0.tar.bz2"

fi
# -------------------------------------------------------

# -----------------------GO  ----------------------------
export GO=y       # 安装go环境

export GO_FILE_URL="https://golang.org/dl/go1.17.2.linux-amd64.tar.gz" # go文件地址
export GO_FILE_NAME="go1.17.2.linux-amd64.tar.gz" # go文件名
export GO_VERSION="go1.17.2.linux-amd64 " # go版本

# -------------------------------------------------------

# -----------------------VIM ----------------------------
export VIM=y       # 安装最新版vim

if [ ${VIM} ]; then
     # 配置vim
    export VIM_CFG=y
    export VIM_RC="https://raw.githubusercontent.com/hanjingo/reborn/main/.vimrc" # vim配置文件
    export VIM_GIT="https://github.com/vim/vim.git" # vim git地址
    export VIM_VUNDLE_GIT="git@github.com:VundleVim/Vundle.vim.git" # vim Vundle git地址
    export VIM_CODE_DARK_GIT="git@github.com:tomasiser/vim-code-dark.git" # vim 暗黑主题 git地址
    export VIM_YCM_GIT="git@github.com:ycm-core/YouCompleteMe.git" # vim YouCompleteMe git地址

    # 编译YouCompleteMe插件
    export BUILD_YCM=y 
    export YCM_CPP=y   # 编译YCM的c++支持
    export YCM_GO=y    # 编译YCM的go支持
    export YCM_RUST=y  # 编译YCM的rust支持
    export YCM_JAVA=y  # 编译YCM的java支持
    export YCM_TS=y    # 编译YCM的javascript支持
    
fi

# -------------------------------------------------------
cd ${TMP}

# 执行基本软件安装脚本
curl https://raw.githubusercontent.com/hanjingo/reborn/main/install.sh >> install.sh
sudo chmod +x install.sh
sh install.sh

# 执行环境配置脚本
curl https://raw.githubusercontent.com/hanjingo/reborn/main/env.sh >> env.sh
sudo chmod +x env.sh
sh env.sh

# 执行第三方软件安装脚本
curl https://raw.githubusercontent.com/hanjingo/reborn/main/3rd.sh >> 3rd.sh
sudo chmod +x 3rd.sh
sh 3rd.sh

# 删除临时文件夹
rm -rf ${TMP}
