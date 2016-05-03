#!/bin/bash

IP_LIST=$(cat /root/.ssh/config | grep HostName | awk '{ print $2 }')
echo $IP_LIST

for item in $IP_LIST
do
   echo "processing $item"
   ssh-keygen -f "/root/.ssh/known_hosts" -R $item   
   ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 ubuntu@$item "sudo cp ~/.ssh/authorized_keys /root/.ssh"
   ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 root@$item "exit"

done

