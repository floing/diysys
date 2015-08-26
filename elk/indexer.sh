#/bin/bash
# codding: utf-8
# Gmail: haojunyu2012
# Description:	服务端配置


echo -n "Have you set up the server ip in the file openssl.conf?(y/n)"
read yn
if [ -z $yn ];
then
	yn="y"
fi
if [ "$yn" == "n" ];
then
	echo "1) You need set up the server ip in the file openssl.conf first."
	exit 1
fi


### 安装java
# 安装openjdk
sudo apt-get -y install openjdk-7-jdk


### 安装redis
sudo apt-get -y install redis-server
echo "===="
echo "redis-server安装完成，更改配置/etc/redis/redis.conf中绑定ip为0.0.0.0"
echo "===="
sudo cp /etc/redis.conf /etc/redis/redis.conf.bak
sudo cp ./redis.conf /etc/redis/redis.conf

### 安装elasticsearch
# 导入GPG key
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

# 添加elasticsearch到源（source list）中
echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list

# 更新软件包数据库
sudo apt-get update > /dev/null

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
sudo apt-get update > /dev/null

# 安装logstash
sudo apt-get -y install logstash
 
# 配置logstash
# 1.向/etc/logstash/conf.d/文件夹中添加配置文件
# 2.在/etc/init.d/logstash中指名配置文件为/etc/logstash/conf.d/*.conf
echo "===="
echo "logstash已经安装，下面对logstash进行配置!!!"
echo "===="
sudo cp ./indexer.conf /etc/logstash/conf.d/
sudo cp ./logstash /etc/init.d/logstash

# 启动logstash服务
sudo service logstash restart

# 设置logstash开机启动,比elasticsearch启动快，关闭慢
sudo update-rc.d logstash defaults 94 11


## 安装Kibana
# 下载kibana软件
wget -O /tmp/kibana.tar.gz https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz

# 解压到/opt/kibana
sudo tar xvf /tmp/kibana.tar.gz -C /opt/
sudo mv /opt/kibana-4.0.1-linux-x64 /opt/kibana

# 配置kibana
# 1.更改配置文件/opt/kibana/config/kibana.yml中host为“localhost”
# 2.向/etc/init.d添加kibana服务文件kibana4
echo "===="
echo "kibana已经安装，下面对kibana进行配置!!!"
echo "===="
sudo cp ./kibana.yml /opt/kibana/config/
sudo cp ./kibana4 /etc/init.d/

# 启动kibana服务
sudo service kibana4 restart

# 设置kibana4开机启动,比elasticsearch启动慢，关闭快
sudo update-rc.d logstash defaults 96 9


## 构建SSL证书
# 创建证书目录
sudo mkdir -p /etc/pki/tls/certs
sudo mkdir /etc/pki/tls/private

# 在/etc/ssl/openssl.cnf配置文件中[v3_ca]下添加subjectAltName=IP:logstash_server_ip
cp /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.bak
cp ./openssl.cnf /etc/ssl/openssl.cnf

# 通过openssl.cnf创建证书
pushd $PWD
cd /etc/pki/tls
sudo openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
popd

# 重启logstash服务
sudo service logstash restart

# 拷贝/etc/pki/tls/certs/logstash-forwarder.crt到shipper机器同目录下
echo "===="
echo "拷贝/etc/pki/tls/certs/logstash-forwarder.crt到shipper机器同目录下"
echo "===="


## 安装反向代理工具Nginx
# 安装nginx和apache2-utils(有apache的web服务器内置工具，如htpasswd)
sudo apt-get -y install nginx apache2-utils

# 创建kibanaadmin用户来访问kibana网络接口，密码为kibanaadmin
# -c 创建文件 | -b 命令行中输入账户密码
sudo htpasswd -bc /etc/nginx/htpasswd.users kibanaadmin kibanaadmin

# 配置nginx[修改/etc/nginx/sites-available/default]
echo "===="
echo "nginx已经安装，下面对nginx进行配置!!!"
echo "===="
sudo cp ./default /etc/nginx/sites-available/

# 重启nginx服务
sudo service nginx restart

