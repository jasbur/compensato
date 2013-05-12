#!/bin/bash

cd /home/compensato

sudo rails s -e production &

sleep 5

chromium-browser http://localhost:3000 -start-maximized