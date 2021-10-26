#!/bin/bash

# 配置环境 
mkdir -p ~/tmp
export TMP=~/tmp
export BAK=${TMP}/bak

# ---------------------------------------------------
export BASE_APP=y # 安装基本软件
export CPP=y      # 安装c++环境
export GO=y       # 安装go环境
export VIM=y      # 安装最新版vim
export CHROME=n   # 安装chrome
export IPFS=y     # 安装ipfs
export FRPC=y     # 安装frpc
export FRPS=y     # 安装frps

# ---------------------------------------------------
export CFG_ALIAS=y    # 配置别名
export CFG_CTAGS=y    # 配置ctags
export CFG_VIM=y      # 配置vim
export CFG_SSH=y      # 配置ssh
export CFG_SSH_SERV=y # 配置ssh服务器
export CFG_GIT=y      # 配置git
export CFG_GOPROXY=y  # 配置go的国内代理

# ---------------------------------------------------
if [ ${CFG_VIM} ]; then
export BUILD_YCM=y # 是否编译YouCompleteMe插件
export YCM_CPP=y   # 是否编译YCM的c++支持
export YCM_GO=y    # 是否编译YCM的go支持
export YCM_RUST=y  # 是否编译YCM的rust支持
export YCM_JAVA=y  # 是否编译YCM的java支持
export YCM_TS=y    # 是否编译YCM的javascript支持
fi

# ---------------------------------------------------
cd ${TMP}

# 执行资源限制脚本
#sudo chmod +x limit.sh
#nohup limit.sh &>/dev/null &

# 执行软件安装脚本
sudo chmod +x install.sh
sh install.sh

# 执行环境配置脚本
sudo chmod +x env.sh
sh env.sh

# 删除临时文件夹
rm -rf ${TMP}
