#!/bin/bash

# ---------------------------安装clash--------------------
cd ${TMP}
if [ ${CLASH} ]; then
    git clone git@github.com:Dreamacro/clash.git
    if [ $(which go) ]; then
        cd clash
        git submodule update --recursive --init
        go mod download
        make ${PLATFORM}
        if [ -f clash ]; then
            sudo mkdir -p /usr/local/bin/.data
            sudo cp clash /usr/local/bin/.data
            sudo ln -snf /usr/local/bin/clash /usr/local/bin/.data
        fi
    fi
fi
# --------------------------------------------------------


# ---------------------------安装ipfs---------------------

# --------------------------------------------------------


# ---------------------------安装frpc---------------------

# --------------------------------------------------------


# ---------------------------安装frps---------------------

# --------------------------------------------------------
