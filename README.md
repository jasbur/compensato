Compensato
==============

Compensato will eventually be a full suite of diagnostic and troubleshooting tools (focused on troubleshooting Windows environments at the moment) that will run from an Ubuntu based Linux live environment. The intent is for it to be packaged as a ready to burn and boot image when it reaches a mature enough state. For now it can be run from any Ubuntu 12.10 environment that also has access to a Windows installation on any partition.

This program requires Ruby on Rails 3.2 running on a Linux/Unix based system. Just enter the Compensato directory and run with:

rails s

Then navigate to 127.0.0.1:3000 or localhost:3000 in your browser of choice.

Requirements:

Ubuntu 12.10
Rails 3.2.6
Curl 7.27.0
smartmontools 5.43
Wine 1.4.1