# node_exporter 使用帮助
Node Exporter 是专门用来采集 *NIX 系统的硬件和操作系统性能指标的工具，它采用 Golang 编写，不存在任何的第三方依赖，只需要下载，解压即可运行。

## 监控内容
### 参数说明
访问 http://部署IP:9100/metrics 可以查看到 node_exporter 采集机器的所有指标。其样例如下：
```bash
# HELP node_cpu Seconds the cpus spent in each mode.
# TYPE node_cpu counter
node_cpu{cpu="cpu0",mode="idle"} 362812.7890625
# HELP node_load1 1m load average.
# TYPE node_load1 gauge
node_load1 3.0703125
```
每个指标都会包含两行注释，
一行表示指标描述，介绍该指标的含义，像 node_cpu 监控的就是 cpu 在不同 mode 下占用 cpu 的时间
一行表示指标类型，表明数据的类型，一共有四种类型，比较常用的是只增不减的计数器（counter）和自由变化的仪表盘（gauga）。

### 参数类型
#### 系统整体
包含系统的状态信息
* node_boot_time_seconds  启动时间 
* node_load*  系统负载
* node_time_seconds 系统时间 

#### CPU
该指标主要集中在 node_cpu* 中。
对应的状态说明如下：
* user  
  CPU运行在用户态空间的时间，也就是用户进程占比。用户空间程序是不属于内核的任何进程。
* system    
  CPU运行在内核空间的时间。所有进程和系统资源都有liunx内核处理。
* iowait    
  读写磁盘的操作比CPU的运行时间慢，CPU负责处理数据，而数据一般在磁盘上需要读到内存中才能处理。当CPU发起读写操作后，需要等着磁盘驱动器将数据读入内存，从而导致CPU等待一段时间无事可做。CPU处于这种状态的等待时间就是iowait时间。
* idle  
  CPU处于空闲状态的时间比例
* irq＆softirq  
  处理器为中断服务的时间。irq用于硬件中断，softirq用于软件中断。
* nice  
  用户空间进程的CPU的调度优先级，可以通过调整期优先级来调整用户空间的优先级

#### 内存
该指标主要集中在 node_memory* 中。

* 内存查看命令 
  ```bash
  # 每隔2秒输出内存信息
  free -h -s 2
  ``` 
* free vs avaliable  
  free 是从操作系统角度看没有被使用的物理内存  
  available 是从应用程序的角度看可用的内存，它包含free， buffer 和 cache 
* buffer vs cache  
  buffer(Buffer Cache) 是一种I/O缓存，用于内存和硬盘的缓冲，是IO设备的读写缓冲区。  
  cache(Page Cache) 是一种高速缓存，用于CPU和内存之间的缓冲，是文件系统的缓冲区。
* 释放内存  
  ```bash
  # 清除数据以前记得sync，先同步缓存中的数据至硬盘，以免数据丢失。
  echo 1 > /proc/sys/vm/drop_caches  # 1表示清除page cache数据
  echo 2 > /proc/sys/vm/drop_caches  # 2表示清除slab分配器中的对象（包括目录项缓存和inode缓存）
  echo 3 > /proc/sys/vm/drop_caches  # 3表示清除pagecache和slab分配器中的缓存对象
  ``` 

#### 磁盘
该指标主要集中在 node_disk* 中。

#### 文件系统
该指标主要集中在 node_filesystem* 中。

#### 网络
该指标主要集中在 node_network* 中。

#### go
该指标主要集中在 go_* 中。

#### 自身进程相关
该指标主要集中在 process_* 中。




## 常见用法
### 基本监控
* 系统运行时间
```bash
sum(time() - node_boot_time_seconds{instance=~"$instance"})
```

* 内核数
```bash
sum(count(node_cpu_seconds_total{instance=~"$instance",mode="system"}) by (cpu))
```
* 内存
```bash
sum(node_memory_MemTotal_bytes{instance=~"$instance"})
```
> **Tips:**
> 
> 
> 

* 磁盘
```bash
sum(node_filesystem_size_bytes{instance=~"$instance"})
```

### 高级用法




## 常见问题
1. hostname
sum by (instance,nodename) (node_load5 * on(instance) group_left(nodename) node_uname_info) 

## 参考文献
1. [node_exporter仓库][github_nodeExporter]
2. [内存管理free][free]

[github_nodeExporter]:https://github.com/prometheus/node_exporter
[free]:https://www.cnblogs.com/guge-94/p/12359841.html



