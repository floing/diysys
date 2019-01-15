#!/bin/bash
# coding:   utf-8
# Author:   hjy
# Gmail:    haojunyu2012@gmail.com
# Detail:   此脚本包含shell中常用的功能函数

# 添加用户
function addUser(){
  if [$# -lt 1 ]
  then
    echo "Usage: $0 user"
    return -1
  fi

  useradd -d /home/$1 -m -s /bin/bash $1
  passwd $1<<EOF
$1
$1
EOF
}

# 获取$1天前的日期，如20170801
function getDayAgo(){
  if [ $# -lt 1 ]
  then
    echo "Usage: $0 n_day_ago"
    return -1
  fi

  sys=`uname -s`
  if [ $sys = "Darwin" ]
  then
    day_ago=`date -v -$1d +"%Y%m%d"`
  elif [ $sys = "Linux" ]
  then
    day_ago=`date -d"$1 day ago" +"%Y%m%d"`
  fi

  echo $day_ago
  
}

# 杀进程$1
function killProcess() {
  if [ $# -lt 1 ]
  then
    echo "Usage: $0 process_name"
    return -1
  fi

  pid=`ps aux | grep "$1" | grep -v "grep" | grep -v "vi" | awk -F" " '{print $2}'`
  pidnum=`echo $pid | wc | awk '{print $2}'`

  if [ $pidnum -ne 0 ]; then
    echo "$pidnum process is running"
    echo $pid | xargs kill > kill.log 2>&1
    echo "kill $1"
  fi
}




