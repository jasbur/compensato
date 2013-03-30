#!/bin/bash

#Copy new sources.list to /etc/apt
cp sources.list /etc/apt/

#Copy grub configuration file to /etc/default
cp grub /etc/default/

#Install dependencies
apt-get update
apt-get upgrade -y
apt-get install rails3 curl smartmontools wine gdisk -y

#Copy the launch script
cp launch_compensato.sh /home/

#Set the script to auto-run on login
mkdir /home/ubuntu
cp .gnomerc /home/ubuntu/