#!/bin/bash

cd /home/compensato

sudo rails s -e production &

sleep 8

cd /home/compensato/working_files/compensato-gui/

quickly run