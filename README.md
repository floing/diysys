# DIY自己的ubuntu系统
## 初衷
针对自己的使用习惯，配置自己的操作系统。整个的配置是以ubuntu系统为基础的。

## 配置内容
### github
1. 对应的文件.gitconfig
2. 重点
	* 如何给git设置代理
	
	```bash
	# git让https代理
	git config --global https.proxy http://proxy_username:proxy_password@proxy_ip:port
	```

### docker
docker环境的配置

### elk日志分析系统
elk日志分析系统的配置

### vim插件及配置
vim环境的配置以及一些实用的插件  
1. 安装vim[/usr/share]，vim-scripts[/usr/share]，vim-doc
2. 安装vim中文帮助文档
3. 设置个性化的vim[~/.vimrc]（不懂的命令可以用`:help command`查看中文帮助文档）
4. 安装插件
	1. 

## 系统常用脚本
### 系统清理--clean.sh
系统清理主要从以下四个方面入手：  
1. 清除比较大且不常用的软件（图形软件synaptic）
2. 删除多余的内核镜像（图形软件synaptic）
3. 清理apt-get install安装下载的软件包（/var/cache/apt/archive目录下）
4. 清理不需要的包，一般是安装软件时附带的依赖包
清理完成后，会打开磁盘使用分析器baobab，用来展示当前系统中磁盘使用情况。

> **Tips:**  
> 清理过程中的日志将保存在clean.log文件中，以方便后面进行查看分析。


