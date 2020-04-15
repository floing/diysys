# hadoop完全分布式构建

## vmware虚拟机准备 
VMware VMnet8 模式共享主机网络配置静态 IP 和 DNS
https://blog.csdn.net/axing2015/article/details/81516627

宿主机的DNS

NAT的IP设置
192.168.209.0
255.255.255.0
192.168.209.2

* VMnet8 ip地址设置（与NAT模式一致）和DNS设置（与宿主机一致）
* 去掉VMnet8中  使用本地DHCP服务将IP地址分配给虚拟机

## 安装步骤
### 准备工作
* 创建用户及sudo权限
```bash
# 创建 apache 用户组
groupadd apache
# 创建 hadoop 用户，并归属 apache
useradd -d /home/hadoop -m -s /bin/bash -g apache hadoop
# 设置用户密码
echo "hadoop" | passwd --stdin hadoop
# 给 apache 用户组添加 sudo 权限
cat >> /etc/sudoers << done
#表示apache组下所有用户都可以执行sudo，且不用密码
%apache  ALL=(ALL) NOPASSWD: ALL
done
```

* 变更主机名
```bash
# 变更主机名/etc/hostname
hostnamectl set-hostname hadoop1
# 识别其它主机
cat >> /etc/hosts << done
192.168.209.111 hadoop1
192.168.209.112 hadoop2
192.168.209.113 hadoop3
done
# 发送给其它主机
scp /etc/hosts hadoop1:/etc/
```

* 关闭防火墙和selinux（可选）
```bash
# 关闭防火墙（centos mini默认没有）
service iptables stop
# 关闭selinux
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/g' /etc/selinux/config
```

* 免密登陆
```bash
# 切换到hadoop用户
su - hadoop
# 生成公私钥
ssh-keygen -f ~/.ssh/id_rsa -N ''
# 发送公钥
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop1
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop2
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop3
```

* 时间同步（分布式必须）
```bash
# 安装ntpdate
sudo yum install -y ntpdate
# 同步时间
sudo ntpdate ntp1.aliyun.com
```


### 安装java（不是open-jdk）
* 卸载 open-jdk
```bash
# 查询自带的open-jdk（centos mini中没有）
sudo rpm  -qa | grep jdk
# 如果有，删除的命令如下
sudo rpm -e java-xxx-openjdk-xxx --nodeps
```

* 安装jdk
```bash
# 获取jdk包
curl -fSL https://repo.huaweicloud.com/java/jdk/8u181-b13/jdk-8u181-linux-x64.tar.gz -o /tmp/jdk-8u181-linux-x64.tar.gz
# 解压缩到制定目录
sudo tar -xzf /tmp/jdk-8u181-linux-x64.tar.gz -C /usr/local
# 创建软链
cd /usr/local && sudo ln -s jdk1.8.0_181 jdk
# 变更文件属主
sudo chown -R hadoop:apache /usr/local/jdk
sudo chown -R hadoop:apache /usr/local/jdk1.8.0_181
# 配置环境变量/etc/profile
sudo sed -i '$a\export JAVA_HOME=/usr/local/jdk\nexport PATH=$PATH:$JAVA_HOME/bin' /etc/profile
# 环境变量生效
source /etc/profile
# java命令验证
java -version
```

### 安装启动hadoop
* 安装
```bash
# 获取jdk包
curl -fSL https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/core/hadoop-2.7.7/hadoop-2.7.7.tar.gz -o /tmp/hadoop-2.7.7.tar.gz
# 解压缩到制定目录
sudo tar -xzf /tmp/hadoop-2.7.7.tar.gz -C /usr/local
# 创建软链
cd /usr/local && sudo ln -s hadoop-2.7.7 hadoop
# 变更文件属主
sudo chown -R hadoop:apache /usr/local/hadoop
sudo chown -R hadoop:apache /usr/local/hadoop-2.7.7
# 修改配置文件
## 伪分布式
cp *.single /usr/local/hadoop/etc/hadoop/
## 分布式
cp *.distributed /usr/local/hadoop/etc/hadoop/
# 配置环境变量/etc/profile
sudo sed -i '$a\export HADOOP_HOME=/usr/local/hadoop\nexport PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' /etc/profile
# 环境变量生效
source /etc/profile
# 命令验证
hadoop version
## 多台机器可以使用 scp 发送配置好的hadoop文件夹
```

* 启动
```bash
# 格式化 namenode 节点
hadoop hdfs -format
# 启动 hdfs
sh start-dfs.sh
# 启动 yarn
sh start-yarn.sh
# 验证进程数
jps
# 验证 hdfs 页面
curl http://192.168.209.11:50070
# 验证 yarn 页面
curl http://192.168.209.11:8088
```

