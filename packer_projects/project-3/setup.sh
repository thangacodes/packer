#!/bin/bash
echo "The script is executed at:" $(date '+%Y-%m-%d %H:%M:%S')
sudo yum update -y
sudo yum install -y java
sudo yum install -y wget
sudo yum install -y putty
sudo yum install -y nginx
sudo systemctl enable nginx
exit
