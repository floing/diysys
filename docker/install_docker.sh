#!/bin/bash
# coding:	utf-8
# Author:	hjy
# Gmail:	haojunyu2012@gmail.com
# detail:	此docker配置脚本目前仅适用于ubuntu版本

if [ `id -u` -ne 0 ];
then
	echo "It must be executed by root!"
	exit 1
fi

#### update kernel
if [ "3.10" \> 'uname -r ' ];
then
	echo "The kernel need to be updated!"
	apt-get update
	apt-get install linux-image-generic-lts-raring  linux-headers-generic-lts-raring
	reboot
fi

#### from http://yeasy.gitbooks.io/docker_practice/content/install/ubuntu.html#docker
apt-get install apt-transport-https
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
bash -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
apt-get update
apt-get install lxc-docker -y --force-yes


#### configure docker
cat <<EOF>> /etc/default/docker
DOCKER_OPTS="-H unix:///var/run/docker.sock -H 0.0.0.0:4243 --insecure-registry 127.0.0.1:5000"
EOF


