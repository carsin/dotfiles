#!/usr/bin/bash

timeout 5 wal -a 90 --backend haishoku -i ~/files/photos/wallpapers/wal &
wait 
pywalfox update 
killall -USR1 /usr/local/bin/st
