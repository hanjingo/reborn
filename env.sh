#!/bin/bash

cd ${TMP} 

# 配置别名
if [ ${ALIAS_CFG} ]; then
    if [ -f ~/.aliases ]; then
        mv ~/.aliases ~/.aliases.bak
    fi
    curl ${ALIAS_FILE_URL} >> ${TMP}/.aliases
    cp -f ${TMP}/.aliases ~/
    if [ ! ${aliases} ]; then
        echo -e "\naliases=y" >> ~/.bashrc
        echo -e "\nif [ -f ~/.bashrc ]; then\n	. ~/.aliases\nfi" >> ~/.bashrc
    fi
    source ~/.bashrc
fi

# 配置ctags
if [ ${CTAGS_CFG} ]; then
    if [ -f ~/.ctags ]; then
        mv ~/.ctags ~/.ctags.bak
    fi
    curl ${CTAGS_FILE_URL} >> ${TMP}/.ctags
    cp -f ${TMP}/.ctags ~/

    if [ ! ${CTAGS} ]; then
        echo -e '\nCTAGS='$(which ctags) >> ~/.bashrc
    fi
fi

# 配置vim
if [ ${VIM_CFG} ]; then

    if [ -f ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc.bak
    fi
    curl ${VIM_RC} >> ${TMP}/.vimrc
    cp -f ${TMP}/.vimrc ~/

    if [ -d ~/.vim ]; then
        mv ~/.vim ~/.vim.bak
    fi

    mkdir -p ~/.vim/bundle
    mkdir -p ~/.vim/colors

    # 添加vundle插件
    cd ~/.vim/bundle
    git clone ${VIM_VUNDLE_GIT}
    cd Vundle.vim
    git submodule update --recursive --init

    # 添加vim-code-dark插件
    cd ~/.vim/bundle
    git clone ${VIM_CODE_DARK_GIT}
    if [ -f ~/.vim/bundle/colors/codedark.vim ]; then
        cp ~/.vim/bundle/colors/codedark.vim ~/.vim/colors/
    fi
   
    # 添加YouCompleteMe插件
    cd ~/.vim/bundle
    git clone ${VIM_YCM_GIT}
    if [ ${BUILD_YCM} ]; then # 编译YCM
        if [ -d ~/.vim/bundle/YouCompleteMe ]; then
            cd ~/.vim/bundle/YouCompleteMe
            git submodule update --recursive --init

            cmd='./install.py'

            if [ ${YCM_CPP} ]; then # 编译YCM的c++
                cmd=${cmd}" --clangd-completer"
            fi

            if [ ${YCM_GO} ]; then # 编译YCM的go
                cmd=${cmd}" --go-completer"
            fi

            if [ ${YCM_RUST} ]; then # 编译YCM的go
                cmd=${cmd}" --rust-completer"
            fi

            if [ ${YCM_JAVA} ]; then # 编译YCM的java
                cmd=${cmd}" --java-completer"
            fi

            if [ ${YCM_TS} ]; then # 编译YCM的js
                cmd=${cmd}" --ts-completer"
            fi

            ${cmd}
        fi
    fi

fi

# 配置git用户名和邮箱
if [ ${CFG_GIT} ]; then
    echo "\nplease input the github(or other) email:"
    read email
    ssh-keygen -t rsa -C "${email}"

    echo "\nplease input the github(or other) user name:"
    read uname
    git config --global user.name "${uname}"
    git config --global user.email "${email}"
fi

# 配置ssh服务器
if [ ${CFG_SSH_SERV} ]; then
    if [ -f /etc/ssh/sshd_config ]; then # 设置保活
        sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
        sudo sed -i "s/#ClientAliveInterval 0/ClientAliveInterval 60/g" /etc/ssh/sshd_config
        sudo sed -i "s/#ClientAliveCountMax 3/ClientAliveCountMax 3/g" /etc/ssh/sshd_config
        sudo grep ClientAlive /etc/ssh/sshd_config
        sudo service sshd reload
    fi
fi

# 配置go国内代理
if [ ${CFG_GOPROXY} ]; then
    if [ $(which go) ]; then
        go env -w GOPROXY=https://goproxy.cn,direct
    fi
fi
