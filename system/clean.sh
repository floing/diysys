#!/bin/bash
# coding:	utf-8
# Author:	hjy
# Gmail:	haojunyu2012@gmail.com
# detail:	此脚本用于清理系统垃圾，特别是当磁盘将满时。目前仅适用于ubuntu版本

log=clean.log
date >> $log
# 用synaptic管理安装的软件
echo "++安装synaptic" >> $log
sudo apt-get -y install synaptic >> $log

echo "删除比较大且不常用的软件---"
echo "删除多余的内核镜像---"
echo "++synaptic操作" >> $log
sudo synaptic >> $log


# 清理apt-get install安装下载的软件包（/var/cache/apt/archives目录下）
echo "++清理apt-get install安装下载的软件包" >> $log
sudo apt-get autoclean >> $log
sudo apt-get clean >> $log


# 清理不再需要的包，一般是安装软件时附带安装依赖的包
echo "++清理不再需要包，一般是安装软件时附带安装依赖的包" >> $log
sudo apt-get -y autoremove >> $log


# 查看磁盘使用分析器，了解磁盘具体使用情况
echo "磁盘使用分析器正在扫描磁盘，请稍等---"
baobab >> $log

echo "====" >> $log
