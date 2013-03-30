#!/bin/bash

cd /home/compensato
sudo rails s &
sleep 10
firefox http://localhost:3000