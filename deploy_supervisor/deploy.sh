#!/bin/bash

source ~/.bash_profile

shdir=$PWD 
cd $shdir

ip_list="172.19.219.242 172.19.219.244 172.19.219.245 172.19.219.247 172.19.219.253 172.19.219.254 172.19.219.255 172.19.220.0 172.19.220.1 172.19.220.2 172.19.220.3 172.19.220.5"
#ip_list="172.19.219.242 172.19.219.244 172.19.219.245 172.19.219.247 172.19.219.253"
#ip_list="172.19.220.5  172.19.220.7"
#ip_list="172.19.219.244 172.19.219.247 172.19.219.245 172.19.220.0 172.19.219.254 172.19.219.255 172.19.219.242 172.19.220.1 172.19.220.2  172.19.220.3"
for ip in ${ip_list}
do
    scp  -r super_install sitereconline@${ip}:~/
    sleep 2
    #ssh sitereconline@${ip} "cd wifi_user_rec_nearline/admin; sh restart.sh;"
    #echo "------------------ deploy ${ip} ok -------------------------..."
    echo ""
done
echo 'deploay all success'
exit

