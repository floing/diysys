#!/bin/bash
# coding:   utf-8
# Author:   hjy
# Gmail:    haojunyu2012@gmail.com
# Detail:   此脚本用于Ubuntu/Mac系统中git的安装，目前适用于ubuntu版本


if which apt-get > /dev/null; then
    echo "You are using Ubuntu!"
    
    # 安装git
    sudo apt-get install -y git unzip
    wget -qO git_config.zip "http://sh-btfs.yun.ftn.qq.com/ftn_handler/1dda77f7d1c2286fa5735f65e8b9edeaa31bb62d699735893292b034efb5ddce/?fname=git_config.zip&from=30111&version=2.0.0.2&uin=1064146151"
    unzip git_config.zip
    if [ ! -d "~/.ssh"]
    then
        mkdir "~/.ssh"
    fi
    mv github ~/.ssh/
    mv github.pub ~/.ssh
    mv known_hosts ~/.ssh
    echo "https://haojunyu:Hjy928928@github.com" >> ~/.git-credentials
    echo "https://haojunyu:Hjy928928@gitcafe.com" >> ~/.git-credentials
    git config --global user.name "haojunyu"
    git config --global user.email "haojunyu2012@gmail.com"
    git config --global push.default simple
    git config --global credential.helper store
    git remote add gitcafe https://gitcafe.com/haojunyu/haojunyu.git
    echo "Git is installed!"
    
    # jekyll配置
    sudo apt-get install -y ruby2.0 ruby2.0-dev
    pushd /usr/bin/
    sudo ln -sf ruby2.0 ruby
    sudo ln -sf gem2.0 gem
    sudo ln -sf erb2.0 erb
    sudo ln -sf irb2.0 irb
    sudo ln -sf rake2.0 rake
    sudo ln -sf rdoc2.0 rdoc
    sudo ln -sf testrb2.0 testrb
    popd
    gem sources --remove https://rubygems.org
    gem sources -a https://ruby.taobao.org
    sudo gem install bundler
    sudo apt-get install -y libxslt1-dev libxml2-dev zlib1g-dev
    bundle install
    echo "Jekyll is installed!"
    

elif which yum > /dev/null; then
    echo "You are using CentOS!"

elif which brew > /dev/null; then
    echo "You are using Mac OS X!"
fi



