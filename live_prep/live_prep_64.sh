#!/bin/bash

#Copy new sources.list to /etc/apt
cp sources.list /etc/apt/

#Copy grub configuration file to /etc/default
cp grub /etc/default/

#This is to bypass some bug in Ubuntu 12.10 that doesn't allow wine to install properly otherwise
sudo dpkg --add-architecture i386

#Install dependencies
apt-get update
apt-get upgrade -y
apt-get install rails3 curl smartmontools wine gdisk -y

#Copy the launch script
cp launch_compensato.sh /home/

#Set the script to auto-run on login
mkdir /home/ubuntu
cp .gnomerc /home/ubuntu/