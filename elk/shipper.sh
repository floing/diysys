#/bin/bash
# codding: utf-8
# Gmail: haojunyu2012
# Description:	客户端配置



echo -n "Have you set up the server ip in the file shipper.conf and logstash-forwarder.conf?(y/n)"
read yn
if [ -z $yn ];
then
	yn="y"
fi
if [ "$yn" == "n" ];
then
	echo "You need set up the server ip in the file shipper.conf first."
	exit 1
fi


### 安装java
# 安装openjdk
sudo apt-get -y install openjdk-7-jdk


### 安装redis
sudo apt-get -y install redis-server


## 安装logstash
# 添加logstash到源中
echo 'deb http://packages.elasticsearch.org/logstash/1.5/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list

# 更新软件包数据库
sudo apt-get update > /dev/null

# 安装logstash
sudo apt-get -y install logstash
 
 # 配置logstash
# 1.向/etc/logstash/conf.d/文件夹中添加配置文件
# 2.在/etc/init.d/logstash中指名配置文件为/etc/logstash/conf.d/*.conf
echo "===="
echo "logstash已经安装，下面对logstash进行配置!!!"
echo "===="
sudo cp ./shipper.conf /etc/logstash/conf.d/
sudo cp ./logstash /etc/init.d/logstash

# 启动logstash服务
sudo service logstash restart

# 设置logstash开机启动,比elasticsearch启动快，关闭慢
sudo update-rc.d logstash defaults 95 10


## 安装logstash-forward
# 添加源
echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | sudo tee /etc/apt/sources.list.d/logstashforwarder.list

# 获取GPG锁钥
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

# 更新源
sudo apt-get update > /dev/null

# 安装logstash-forwarder
sudo apt-get install logstash-forwarder

# 配置logstash-forwarder
echo “====”
echo “请先确认logstash-forwarder.crt文件是否从index机器上拷入同目录”
echo “====”
sudo cp ./logstash-forwarder.conf  /etc/logstash-forwarder.conf

# 重启logstash-forwarder
sudo service logstash-forwarder restart
