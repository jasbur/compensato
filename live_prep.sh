#!/bin/bash

#Add new sources to the /etc/apt/sources.list within the new live environment
echo "deb http://us.archive.ubuntu.com/ubuntu/ quantal universe" >> /etc/apt/sources.list
echo "deb-src http://us.archive.ubuntu.com/ubuntu/ quantal universe" >> /etc/apt/sources.list
echo "deb http://us.archive.ubuntu.com/ubuntu/ quantal-updates universe" >> /etc/apt/sources.list
echo "deb-src http://us.archive.ubuntu.com/ubuntu/ quantal-updates universe" >> /etc/apt/sources.list

echo "deb http://us.archive.ubuntu.com/ubuntu/ quantal multiverse" >> /etc/apt/sources.list
echo "deb-src http://us.archive.ubuntu.com/ubuntu/ quantal multiverse" >> /etc/apt/sources.list
echo "deb http://us.archive.ubuntu.com/ubuntu/ quantal-updates multiverse" >> /etc/apt/sources.list
echo "deb-src http://us.archive.ubuntu.com/ubuntu/ quantal-updates multiverse" >> /etc/apt/sources.list

echo "deb http://security.ubuntu.com/ubuntu quantal-security main restricted" >> /etc/apt/sources.list
echo "deb-src http://security.ubuntu.com/ubuntu quantal-security main restricted" >> /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu quantal-security universe" >> /etc/apt/sources.list
echo "deb-src http://security.ubuntu.com/ubuntu quantal-security universe" >> /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu quantal-security multiverse" >> /etc/apt/sources.list
echo "deb-src http://security.ubuntu.com/ubuntu quantal-security multiverse" >> /etc/apt/sources.list

#This is to bypass some bug in Ubuntu 12.10 that doesn't allow wine to install properly otherwise
sudo dpkg --add-architecture i386

#Install dependencies
apt-get update
apt-get install rails3 curl smartmontools wine

#Create the launch script
echo "#!/bin/bash" >> /home/launch_compensato.sh
echo "cd /home/compensato" >> /home/launch_compensato.sh
echo "sudo rails s -d" >> /home/launch_compensato.sh
echo "firefox http://localhost:3000"
chmod 777 /home/launch_compensato.sh

#Set the script to auto-run on login
echo "[Desktop Entry]" >> /usr/share/xsessions/custom.desktop
echo "Name=Compensato Launcher" >> /usr/share/xsessions/custom.desktop
echo "Comment=Script to launch Compensato automatically" >> /usr/share/xsessions/custom.desktop
echo "Exec=/home/launch_compensato.sh" >> /usr/share/xsessions/custom.desktop
echo "X-Ubuntu-Gettext-Domain=gdm" >> /usr/share/xsessions/custom.desktop