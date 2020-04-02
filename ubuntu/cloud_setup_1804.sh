#!/bin/bash
# coding:   utf-8
# Author:   hjy
# Gmail:    haojunyu2012@gmail.com
# Detail:   此脚本用于配置云服务器（作为中转站，不放内容），仅适用于ubuntu18.04版本
# 之前版本有如下问题：
# * 缺乏监控 目前在这台机器上部署prometheus
# * 容器部署 应用容器化

echo "开始配置Ubuntu云服务器，版本18.04"

# 创建用户hjy和guest
useradd -d /home/hjy -m -s /bin/bash hjy
usermod -aG sudo hjy
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

## 安装rsync
dpkg -s rsync 1>>setup.log 2>&1
if [ $? -eq 1 ]; then
  echo "安装rsync......"
  sudo apt install rsync
  cp /usr/share/doc/rsync/examples/rsyncd.conf /etc/
  systemctl enable rsync
  systemctl start rsync
else
  echo "已经安装rsync"
fi



## 安装nginx
dpkg -s nginx 1>>setup.log 2>&1
if [ $? -eq 1 ]; then
  echo "安装nginx......"
  sudo apt install nginx
else
  echo "已经安装nginx"
fi

## 安装certbot管理域名证书
dpkg -s certbot 1>>setup.log 2>1
if [ $? -eq 1 ]; then
  echo "安装certbot......"
  sudo apt install certbot python-certbot-nginx  # cerbot及其插件
  
  # 配置域名 
  #sudo certbot certonly --cert-name haojunyu.com -d www.haojunyu.com,monitor.haojunyu.com
  # 删除配置的域名
  #sudo certbot delete --cert-name haojunyu.com
  # 查看配置的域名
  #sudo certbot certificates
  # 配置定时更新
  #sudo certbot renew --dry-run
else
  echo "已经安装certbot"
fi


## 安装docker
dpkg -s docker 1>>setup.log 2>&1
if [ $? -eq 1 ]; then
  echo "安装docker......"
  sudo apt install docker
  # 开机自启
  sudo systemctl is-enabled docker
else
  echo "已经安装docker"
fi

