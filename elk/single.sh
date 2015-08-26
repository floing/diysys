#/bin/bash
# codding: utf-8
# Gmail: haojunyu2012
# Description:	ELK单机安装配置



### 安装java
# 安装openjdk
sudo apt-get install openjdk-7-jdk


### 安装redis
sudo apt-get install redis-server


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
sudo apt-get install logstash
 
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
sudo update-rc.d kibana4 defaults 96 9


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

## 

