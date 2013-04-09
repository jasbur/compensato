#!/bin/bash

#Copy and altered configuration files to live environment
cp ./conf_files/limits.conf /etc/security/

#Copy new sources.list to /etc/apt
cp ./conf_files/sources.list /etc/apt/

#This is to bypass some bug in Ubuntu 12.10 that doesn't allow wine to install properly otherwise
sudo dpkg --add-architecture i386

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