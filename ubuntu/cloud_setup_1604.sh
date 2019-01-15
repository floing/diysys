#!/bin/bash
# coding:   utf-8
# Author:   hjy
# Gmail:    haojunyu2012@gmail.com
# Detail:   此脚本用于配置云服务器（作为中转站，不放内容），仅适用于ubuntu16.04版本


echo "开始配置Ubuntu云服务器，版本16.04"

# 创建用户hjy和guest
useradd -d /home/hjy -m -s /bin/bash hjy
useradd -d /home/guest -m -s /bin/bash guest
passwd hjy << EOF
hjy
hjy
EOF
passwd guest << EOF
guest
guest
EOF


# 更换软件源并更新软件（基本不用更换源）
echo "软件源更新......"
#sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
#sudo cp sources.list.1604 /etc/apt/sources.list
sudo apt update & sudo apt upgrade


# 服务器标配
echo "开始集成服务器标配"
dpkg -s nginx 1>>setup.log 2>>&1
if [ $? -eq 1 ]; then
  echo "安装nginx......"
  sudo apt install nginx
else
  echo "已经安装nginx"
fi
echo "安装certbot......"
sudo apt install uwsgi uwsgi-plugin-python  # uwsgi及其插件
echo "安装uwsgi及插件......"
sudo apt install uwsgi uwsgi-plugin-python  # uwsgi及其插件
echo "安装supervisor......"
sudo apt install supervisor # 进程管理
echo "安装npm......"
sudo apt install npm 

######### python ########
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
# 安装python-mysqldb
echo "安装python-mysqldb......"
sudo apt install python-mysqldb libmysqlclient-dev
