#!/bin/bash

cd /home/compensato

sudo rails s -e production &

sleep 8

chromium-browser http://localhost:3000 -start-maximized