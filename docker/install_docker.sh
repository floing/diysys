#!/bin/bash

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
apt-get install lxc-docker


