#!/bin/bash
# coding:	utf-8
# Author:	hjy
# Gmail:	haojunyu2012@gmail.com
# detail:	此脚本用于jdk的配置安装，目前仅适用于ubuntu版本


# jdk文件名称，该文件位于src文件夹中
jdk_file=jdk-8u66-linux-x64.tar.gz
    # 66根据文件中8u66而来
jdk_version=jdk1.8.0_66

# 从网上下载jdk-8u66-linux-x64.tar.gz
wget -qcO jdk-8u66-linux-x64.tar.gz "http://cdxf.yun.ftn.qq.com/ftn_handler/21841a76e812e5d439c4ed683b9644728a1b201aa83493e8b51616244d8c44e7/?fname=jdk-8u66-linux-x64.tar.gz&from=30111&version=2.0.0.2&uin=1064146151"

# 解压文件到/usr/lib/jvm
if [ ! -d "/usr/lib/jvm" ]
then
    sudo mkdir /usr/lib/jvm
fi
sudo tar zxvf src/$jdk_file -C /usr/lib/jvm

# 在~/.bashrc文件中添加环境变量
export JAVA_HOME=/usr/lib/jvm/$jdk_version
export JRE_HOME=${JAVA_HOME}/jre  
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=${JAVA_HOME}/bin:$PATH 

# 配置默认jdk版本
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/$jdk_version/bin/java 300  
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/$jdk_version/bin/javac 300  
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/$jdk_version/bin/jar 300   
sudo update-alternatives --install /usr/bin/javah javah /usr/lib/jvm/$jdk_version/bin/javah 300   
sudo update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/$jdk_version/bin/javap 300 
# 选择新的jdk版本
sudo update-alternatives --config java

