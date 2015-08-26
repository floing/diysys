# Collectd收集CPU信息
## logstash配置文件--cpu.conf
```bash
input{
	## 通过监听25826端口接收从collectd发送过来的各项检测数据（udp协议）
	udp{
		port => 25826
		buffer_size => 1452
		workers => 3
		queue_size => 30000
		codec => collectd{ }
		type => "cpu"
		add_field => {
			"key" => "collectd"
		}
	}
}
output{
	if ( [collectd_type] == "cpu" ){
	# 服务器
		redis{
			host => "redis.anw.eap"
			data_type => "list"
			key => "%{type}"
		}
	}
}
```
通过该配置文件，可以获得一下信息：

key |  description
------- | ----------------
host | 主机
@timestamp | 时间戳
@version | 版本
service | 'collectd'（个人设定）
type | 'cpu'（个人设定）
plugin | collectd的插件--cpu
collectd_type | 与type类似--'cpu'
plugin_instance | cpu实例（多核cpu）0/1/...
type_instance | nice/user/steal/system/idle/wait/interrupt/softirq
value | type_instance对应的取值j

从上表可以看出，collect收集cpu一下8个重要信息，其字段具体含义如下：
* user  
 从系统启动开始累计到当前时刻，用户态的CPU时间（单位：jiffies） ，不包含 nice值为负进程。1jiffies=0.01秒 
* system  
从系统启动开始累计到当前时刻，核心时间（单位：jiffies）
* idle   
从系统启动开始累计到当前时刻，除硬盘IO等待时间以外其它等待时间（单位：jiffies）
* nice  
从系统启动开始累计到当前时刻，nice值为负的进程所占用的CPU时间（单位：jiffies）
* wait   
从系统启动开始累计到当前时刻，硬盘IO等待时间（单位：jiffies） 
* interrupt   
从系统启动开始累计到当前时刻，硬中断时间（单位：jiffies）
* softirq   
 从系统启动开始累计到当前时刻，软中断时间（单位：jiffies）
* steal   
管理程序维护另一个虚拟处理器时，虚拟CPU的无意识等待时间百分比

## collectd配置文件--collectd.conf
打开cpu插件
```sh
LoadPlugin cpu
```

## 结果显示
![collectd_cpu](https://github.wdf.sap.corp/github-enterprise-assets/0000/8707/0001/3600/4807894a-4b28-11e5-8d4e-c712e5ca4af5.png)

