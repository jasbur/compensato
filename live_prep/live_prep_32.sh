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

#Install dependencies
apt-get update
apt-get upgrade -y
apt-get install rails3 curl smartmontools wine -y

#Create the launch script
echo "#!/bin/bash" >> /home/launch_compensato.sh
echo "cd /home/compensato" >> /home/launch_compensato.sh
echo "sudo rails s &" >> /home/launch_compensato.sh
echo "sleep 10" >> /home/launch_compensato.sh
echo "firefox http://localhost:3000" >> /home/launch_compensato.sh
chmod 777 /home/launch_compensato.sh

#Set the script to auto-run on login
mkdir /home/ubuntu
echo "gnome-session --session=ubuntu & unity & /home/launch_compensato.sh" >> /home/ubuntu/.gnomerc