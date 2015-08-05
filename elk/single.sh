#/bin/bash
# codding: utf-8
# Gmail: haojunyu2012
# Description:	ELK单机安装配置



### 安装java
# 安装openjdk
sudo apt-get -y install openjdk-7-jdk


### 安装redis
sudo apt-get -y install redis-server


### 安装elasticsearch
# 导入GPG key
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

# 添加elasticsearch到源（source list）中
echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list

# 更新软件包数据库
sudo apt-get update

# 安装elasticsearch
sudo apt-get -y install elasticsearch=1.4.4

# 配置elasticsearch[/etc/elasticsearch/elasticsearch.yml]
echo "===="
echo "elasticsearch1.4.4已经安装，请对/etc/elasticsearch/elasticsearch.yml文件进行配置!!!"
echo "===="

# 启动elasticsearch服务
sudo service elasticsearch restart

# 设置elasticsearch开机启动
sudo update-rc.d elasticsearch defaults 95 10



## 安装logstash
# 添加logstash到源中
echo 'deb http://packages.elasticsearch.org/logstash/1.5/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list

# 更新软件包数据库
sudo apt-get update

# 安装logstash
sudo apt-get -y install logstash
 
 # 配置logstash
# 1.向/etc/logstash/conf.d/文件夹中添加配置文件
# 2.在/etc/init.d/logstash中指名配置文件为/etc/logstash/conf.d/*.conf
echo "===="
echo "logstash已经安装，下面对logstash进行配置!!!"
echo "===="
sudo cp ./single.conf /etc/logstash/conf.d/
sudo cp ./logstash /etc/init.d/logstash

# 启动logstash服务
sudo service logstash restart

# 设置logstash开机启动,比elasticsearch启动快，关闭慢
sudo update-rc.d logstash defaults 94 11


