#!/bin/bash

#Copy and altered configuration files to live environment
cp ./conf_files/limits.conf /etc/security/

#Copy new sources.list to /etc/apt
cp ./conf_files/sources.list /etc/apt/

#Copy the launch script
cp compensato.sh /usr/bin

#Copy the .desktop file to autostart and run the /home/launch_compensato.sh script when logging in
mkdir -p /home/ubuntu/.config/autostart
cp ./conf_files/Launch_Compensato.desktop /home/ubuntu/.config/autostart

#Copy default wallpaper
cp ./art/wallpaper.png /usr/share/backgrounds/warty-final-ubuntu.png

#Copy the Plymouth boot theme files
cp ./art/* /lib/plymouth/themes/ubuntu-logo/

#This is to bypass some bug in Ubuntu 12.10 that doesn't allow wine to install properly otherwise
sudo dpkg --add-architecture i386

#Remove unwanted packages
apt-get remove ubiquity -y

#Install dependencies
apt-get update
apt-get upgrade -y
apt-get install rails3 curl smartmontools wine gdisk lm-sensors -y

#Create link to the 64 bit version of mprime to run later for torture test
ln -sf ../ext_apps/mprime_statics/mprime64 ../ext_apps/mprime

#Set the script to auto-run on login
mkdir -p /home/ubuntu/Desktop
ln -sf /home/launch_compensato.sh /home/ubuntu/Desktop/Launch\ Compensato
