#/bin/bash
# codding: utf-8
# Gmail: haojunyu2012



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
echo "elasticsearch1.4.4已经安装，请对/etc/elasticsearch/elasticsearch.yml文件进行配置!!!"


