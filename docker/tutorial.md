# 在Docker容器中学习vowpal_wabbit说明

该文件主要对Docker容器中学习vowpal_wabbit作一些说明。之所以用Docker容器是因为
其良好的隔离特性，而相比虚拟机更方便，利用资源更高效。之所以要隔离是因为想要
从源码的层次来学习vowpal_wabbit，包含编译源码，修改源码等。

基础镜像的位置在这里：https://hub.docker.com/r/haojunyu/vowpal_wabbit/.


## 安装稳定的Docker社区版（CE）

- Mac版: 
https://docs.docker.com/docker-for-mac/install/

- Ubuntu版: 
https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/ （也有其他Linux发行版）.

- Windows版 (64bit Windows 10 Pro, Enterprise and Education):
https://docs.docker.com/docker-for-windows/install/ 

- Windows版 (老版本):
https://docs.docker.com/toolbox/toolbox_install_windows/


## 获取容器镜像

获取最新版本的容器镜像：
```sh
docker pull haojunyu/vowpal_wabbit
```
该镜像是在Ubuntu 18.04 LTS版本上安装了编译和执行vowpal_wabbit需要的所有软件。完整的镜像大概多大。

**注意：** 如果你碰到这样的错误提示"Got permission denied while trying to connect to the Docker daemon socket...", 你需要将当前用户添加到docker用户组中并重启docker服务：
```sh
sudo usermod -a -G docker $USER
sudo service docker restart
```


## 首次运行容器

你可以执行下面的命令来首次启动容器：
```sh
docker run -it --name vowpal_wabbit haojunyu/vowpal_wabbit
```

如果你想将本地机器的目录挂载到镜像中，可以使用`-v`选项：
```sh
docker run -it --name vowpal_wabbit -v $PWD:/home/vowpal_wabbit haojunyu/vowpal_wabbit
```
这里使用`$PWD`来挂载当前目录到镜像中的`/home/vowpal_wabbit`目录下。


## 停止和重启容器

停止容器使用如下命令：
```sh
docker stop vowpal_wabbit
```
执行该命令后所有对容器的改动将会被保存。

重启停止的容器使用如下命令：
```sh
docker start -i vowpal_wabbit
```


## 容器的其他操作

以下还列出了一些容器的其他操作。
```sh
docker container list --all
```
该命令会显示运行中的和停止运行的容器。

```sh
docker ps -a
```
该命令会显示当前运行和停止容器以及它们的状态。

```sh
docker rm vowpal_wabbit
```
该命令会删除容器以及和它相关联的数据（容器内部的数据，包含安装的软件包等，但挂载上去的文件将不受影响，因为它在本地机器）。

```sh
docker exec vowpal_wabbit pip3 install PACKAGE_NAME
```
该命令会在容器中安装PACKAGE_NAME

## 容器可使用内存限制

容器的可使用内存限制和物理机器的内存限制不同，该功能可能导致你容器中的代码因为内存不足而崩溃。

* 如果你的操作系统是Windows或OSX，容器默认的内存限制是2G，但是你可以按照下面的教程更改这个值：
  * Windows版: https://docs.docker.com/docker-for-windows/#advanced
  * Mac OSX版: https://docs.docker.com/docker-for-mac/#advanced

* 如果你的操作系统是Linux,那么你容器的内存限制和物理机的内存相等。


## 延展阅读

如果你想了解更多的关于Docker方面的信息，可以查阅一下内容：
If you are interested to know more about Docker, check out this articles: 
- 在Docker中使用Jupyter notebook： https://www.dataquest.io/blog/docker-data-science/
- Docker的介绍： https://docker-curriculum.com/


## Credits

该模板参考此处：https://github.com/ZEMUSHKA/coursera-aml-docker
