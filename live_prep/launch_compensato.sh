#!/bin/bash

cd /home/compensato

sudo rails s -d &&
sleep 5
firefox http://localhost:3000