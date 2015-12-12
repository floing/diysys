#!/bin/bash
# coding:   utf-8
# Author:   hjy
# Gmail:    haojunyu2012@gmail.com
# Detail:   此脚本用于Ubuntu/Mac系统中git的安装，目前适用于ubuntu版本


if which apt-get > /dev/null; then
    echo "You are using Ubuntu!"
    
    #安装osdlyrics--方便rhythmbox显示歌词
    wget -qO osdlyrics.deb "http://cd-btfs.yun.ftn.qq.com/ftn_handler/06cb35e1d0ee3f5dd32a1a8b9602c2365df580867f4c9f4751ce2f775f863494/?fname=osdlyrics_0.4.3-1~precise1_amd64.deb&from=30111&version=2.0.0.2&uin=1064146151"
    echo "change your lyrics path!"
    

elif which yum > /dev/null; then
    echo "You are using CentOS!"

elif which brew > /dev/null; then
    echo "You are using Mac OS X!"
fi



