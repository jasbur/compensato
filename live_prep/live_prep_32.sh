#!/bin/bash

#Copy new sources.list to /etc/apt
cp sources.list /etc/apt/

#Install dependencies
apt-get update
apt-get upgrade -y
apt-get install rails3 curl smartmontools wine gdisk -y

#Remove unwanted packages
apt-get remove ubiquity -y

#Copy the launch script
cp launch_compensato.sh /home/

#Set the script to auto-run on login
mkdir /home/ubuntu
cp .gnomerc /home/ubuntu/