#!/bin/bash
echo "EC2 instance initializing in progress. So, please wait for 30 seconds to proceed next steps...."
sleep 30
echo "The script is executed at:" $(date '+%Y-%m-%d %H:%M:%S')
sudo yum update -y
sudo yum install -y java
sudo yum install -y nginx
sudo systemctl enable nginx
exit

