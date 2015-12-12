#!/bin/bash
# coding:   utf-8
# Author:   hjy
# Gmail:    haojunyu2012@gmail.com
# Detail:   此脚本用于安装Ubuntu/Mac系统里专业的码农工具，目前适用于ubuntu版本



if which apt-get > /dev/null; then
    echo "You are using Ubuntu!"
    
    ####################
    #  专业的码农工具  #
    ####################
    #安装gcc编译环境
    sudo apt-get install -y build-essential
    echo "Gcc is installed!"

    # 安装pathon集成环境idle
    sudo apt-get install -y idle-python2.7

    # 安装jdk
    pushd  ../java
    sudo ./install_jdk.sh
    popd

    # 安装vim
    pushd ../vim
    sudo ./install_vim.sh
    popd


    #安装流程图软件dia
    sudo apt-get install -y dia dia-gnome
    echo "Dia is installed!"

    #安装tex软件
    sudo apt-get install -y texlive-full texlive-fonts-recommended texmaker
	    #安装win下的字体
        wget -qcO addWinFonts.tar.gz "http://sh-btfs.yun.ftn.qq.com/ftn_handler/468d04714a9054927045abc97273a0d8ca22a3c9d7b11b452a9c5eb1ba59579a/?fname=addWinFonts.tar.gz&from=30111&version=2.0.0.2&uin=1064146151"
        tar -zxvf addWinFonts.tar.gz
        pushd addWinFonts
        sudo ./addWinFonts.sh
        popd
        sudo rm -r addWinFonts
    echo "Tex is installed!"


    
    ####################
    #  清理旧版本软件  #
    ####################
    #清理旧版本的软件缓存保留当前版本(sudo apt-get chlen不保留当前版本)
    sudo apt-get autoclean 


elif which yum > /dev/null; then
    echo "You are using CentOS!"

elif which brew > /dev/null; then
    echo "You are using Mac OS X!"
fi



