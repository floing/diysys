#!/bin/bash
# coding:	utf-8
# Author:	hjy
# Gmail:	haojunyu2012@gmail.com
# detail:	此脚本用于ndk的配置安装，目前仅适用于ubuntu版本

# ndk文件名称，该文件位于src文件夹中
ndk_file=android-ndk64-r10-linux-x86_64.tar.bz2

# 解压文件到/usr/lib/jvm
if [ ! -d "/usr/lib/jvm" ]
then
    sudo mkdir /usr/lib/jvm
fi
sudo tar xjvf src/$ndk_file -C /usr/lib/jvm

# 在~/.bashrc文件中添加环境变量
export NDK_HOME=
export PATH=$NDK_HOME:$PATH 


