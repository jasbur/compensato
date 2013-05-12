Compensato
==============

Compensato is full suite of diagnostic and troubleshooting tools (focused on troubleshooting Windows environments 
at the moment) that runs from an Ubuntu based Linux live environment.

Ready to boot ISO files can be found at http://sourceforge.net/projects/compensato/



DEVELOPMENT NOTES:


This program requires Ruby on Rails 3.2 running on a Linux/Unix based system. Just enter the Compensato directory and run with:

sudo rails s

Then navigate to 127.0.0.1:3000 or localhost:3000 in your browser of choice.


The program will automatically look for a Windows installation to work with. You should be able to have this Windows 
installation visible to the system either internally or externally. If you are using an external device to hold the Windows 
partition I recommend unmounting it (or mounting in manually to /media/ubuntu/compensato_client) before running Compensato 
to avoid confusing the automount routine. /media/ubuntu/compensato_client is also where you should mount any dummy or simulated
Windows inatllations for testing.



Prerequisites:

Ubuntu 12.10 
Rails 3.2.6 
Curl 7.27.0 
smartmontools 5.43 
Wine 1.4.1
gdisk 0.8.5
lm-sensors 3.3.1



Compensato is licsenced under the GPLv3

Copyright 2013 Jason Burgett