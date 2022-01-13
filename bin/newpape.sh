#!/usr/bin/bash

wal -a 85 --backend haishoku -i ~/files/photos/wallpapers/wal &
wait
pywalfox update 
killall -USR1 st
