#!/bin/bash
# coding:   utf-8
# Author:   hjy
# Gmail:    haojunyu2012@gmail.com
# Detail:   此脚本用于配置服务器，目前适用于ubuntu16.04版本


echo "开始配置Ubuntu服务器，版本16.04"

# 更换软件源并更新软件
echo "更换软件源并更新......"
sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
sudo cp sources.list.1710 /etc/apt/sources.list
sudo apt update & sudo apt upgrade

# 安装Gnome桌面环境
#sudo apt-get install x-window-system-core  #x-window基础
#sudo apt-get install gnome-core  #gnome基础
#sudo apt-get install language-pack-gnome-zh-hans # 让gnome面板，菜单显示简体中文
#sudo apt-get install language-pack-zh-hans # 简体中文语言包

# 安装编译环境
echo "安装编译环境build-essential......"
sudo apt install build-essential git

# 安装node环境
echo "安装nodejs......"
sudo apt install nodejs
echo "安装npm......"
sudo apt install npm
# 修改npm镜像地址，加快下载;也可设置~/.npmrc
npm config set registry https://registry.npm.taobao.org

# 安装python环境
echo "开始集成python环境"
# 安装pip
echo "安装pip并更新到最新版本......"
sudo apt install python-pip
pip install --upgrade pip
mkdir $HOME/.pip
cp pip.conf $HOME/.pip/

# virtualenv
echo "安装virtualenv和virtualenvwrapper并配置......"
sudo pip install virtualenv
sudo pip install virtualenvwrapper
# virtualenvwrapper配置
cat << EOF >> $HOME/.bashrc
# virtualenvwrapper配置
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi
EOF
source $HOME/.bashrc

# 安装进程管理
echo "安装supervisor......"
sudo apt install supervisor # 进程管理


# 安装数据库
echo "安装mysql......"
sudo apt install mysql-server
echo "安装python-mysqldb......"
sudo apt install python-mysqldb libmysqlclient-dev



