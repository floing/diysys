#!/bin/bash
# coding:   utf-8
# Author:   hjy
# Gmail:    haojunyu2012@gmail.com
# Detail:   此脚本用于安装Ubuntu/Mac系统基本的软件，目前只适用于ubuntu版本


if which apt-get > /dev/null; then
    echo "You are using Ubuntu!"
    
    #################
    #  preparating  #
    #################
    #更新软件源
    sudo apt-get update 
    ##升级系统的软件，该命令会根据依赖关系对一些依赖文件进行删除和安装(sudo apt-get upgrade 对于依赖关系变更的软件不更新)
    sudo apt-get dist-upgrade
    # 删除系统不再使用的孤立软件--危险太大，在安装自己软件之前运行一下还是可以的。
    sudo apt-get autoremove
    #更新语言包--安装中文
    sudo apt-get install  language-pack-zh-hans


    ############################
    #  install base softwares  #
    ############################
    #安装浏览器chrome和在线视频播放插件
    sudo apt-get install -y chromium-borwser pepperflashplugin
    echo "Chromium is installed!"

    #安装压缩工具7zip
    sudo apt-get install -y p7zip-full
    echo "7zip is installed!"
    
    #安装osdlyrics--方便rhythmbox显示歌词
    wget -qO osdlyrics.deb "http://cd-btfs.yun.ftn.qq.com/ftn_handler/06cb35e1d0ee3f5dd32a1a8b9602c2365df580867f4c9f4751ce2f775f863494/?fname=osdlyrics_0.4.3-1~precise1_amd64.deb&from=30111&version=2.0.0.2&uin=1064146151"
    sudo dpkg -i osdlyrics.deb
    sudo apt-get -f install
    echo "Osdlyrics is installed!"
    echo "change your lyrics path!"
    
    #安装视频播放器VLC
    sudo apt-get install -y vlc
    echo "VLC player is installed!"

    #安装位图图像处理gimp
    sudo apt-get install -y gimp
    echo "Gimp is installed!"
    

    #安装starDict字典
    sudo apt-get install -y stardict
        #安装软件所需的字典和发音包
        wget -qcO stardict.tar.gz "http://sh-btfs.yun.ftn.qq.com/ftn_handler/da549824d8062cc796b3fcba60821bcc798b0a7cad6d0a8648816a067e47f8c7/?fname=stardict.tar.gz&from=30111&version=2.0.0.2&uin=1064146151"
        tar -zxvf stardict.tar.gz
        pushd stardict
        sudo sh installDicPro.sh
        popd
        rm -r stardict
    echo "Stardict is installed!"

    #安装atom--黑客级的文本编辑器
    wget -qcO atom.deb "http://sh-btfs.yun.ftn.qq.com/ftn_handler/f00e532d75d9a6c7ecb8a60dc1226a065680314cc70ad39f502e3a9bd6b967e3/?fname=atom-amd64.deb&from=30111&version=2.0.0.2&uin=1064146151"
    sudo dpkg -i atom.deb
    echo "atom is installed!"

    #安装java集成环境Eclipse
    sudo apt-get install -y eclipse-jdt eclipse-pde eclipse-platform eclipse-platform-data eclipse-rcp
    echo "Eclipse is installed!"


    ####################
    #  清理旧版本软件  #
    ####################
    #清理旧版本的软件缓存保留当前版本(sudo apt-get chlen不保留当前版本)
    sudo apt-get autoclean 

    echo "Manual configure..."
    echo "设置osdlyrics歌词路径~/music/lyrics"

elif which yum > /dev/null; then
    echo "You are using CentOS!"

elif which brew > /dev/null; then
    echo "You are using Mac OS X!"
fi


