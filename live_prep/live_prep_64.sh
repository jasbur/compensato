#!/bin/bash

#Copy new sources.list to /etc/apt
cp ./conf_files/sources.list /etc/apt/

#This is to bypass some bug in Ubuntu 12.10 that doesn't allow wine to install properly otherwise
sudo dpkg --add-architecture i386

#Remove unwanted packages
apt-get remove ubiquity firefox -y

#Install dependencies
apt-get update
apt-get upgrade -y
apt-get install rails3 curl smartmontools wine gdisk lm-sensors chromium-browser -y

#Copy and altered configuration files to live environment
cp ./conf_files/limits.conf /etc/security/

#Copy the rails server startup script
cp ./conf_files/launch_compensato_server.sh /usr/bin/

#Copy the launch script
cp ./conf_files/compensato.sh /usr/bin

#Copy rc.local to start the rails server on boot
cp ./conf_files/rc.local /etc

#Copy the .desktop file to autostart and run the /usr/bin/compensato.sh script when logging in
mkdir -p /home/ubuntu/.config/autostart
cp ./conf_files/Launch_Compensato.desktop /home/ubuntu/.config/autostart

#Copy default wallpaper
cp ./art/wallpaper.png /usr/share/backgrounds/warty-final-ubuntu.png

#Copy the Plymouth boot theme files
cp ./art/plymouth_theme/* /lib/plymouth/themes/ubuntu-logo/

#Copy the Plymouth text boot theme files
cp ./art/plymouth_text_theme/* /lib/plymouth/themes/ubuntu-text/

#Create link to the 64 bit version of mprime to run later for torture test
ln -sf ../ext_apps/mprime_statics/mprime64 ../ext_apps/mprime

#Set the script to auto-run on login
mkdir -p /home/ubuntu/Desktop
ln -sf /usr/bin/compensato.sh /home/ubuntu/Desktop/Launch\ Compensato

#Copy Unity launcher favorites
mkdir -p /home/ubuntu/.config/dconf
cp ./conf_files/user /home/ubuntu/.config/dconf

#Change all permissions to 777 in /home/ubuntu
chmod -R 777 /home/ubuntu
