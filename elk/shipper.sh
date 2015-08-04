#/bin/bash
# codding: utf-8
# Gmail: haojunyu2012
# Description:	客户端配置



### 安装java
# 安装openjdk
sudo apt-get install openjdk-7-jdk


### 安装redis
sudo apt-get install redis-server


## 安装logstash
# 添加logstash到源中
echo 'deb http://packages.elasticsearch.org/logstash/1.5/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list

# 更新软件包数据库
sudo apt-get update

# 安装logstash
sudo apt-get install logstash
 
# 配置logstash[向/etc/logstash/conf.d/文件夹中添加配置文件]
echo "===="
echo "logstash已经安装，下面对logstash进行配置!!!"
echo "===="
sudo cp ./shipper.conf /etc/logstash/conf.d/

# 启动elasticsearch
sudo service elasticsearch restart

# 设置elasticsearch开机启动,比elasticsearch启动快，关闭慢
sudo update-rc.d elasticsearch defaults 95 10


