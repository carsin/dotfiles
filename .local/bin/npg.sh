#!/bin/bash

timeout 2 wal -a 80 --backend haishoku -i ~/files/photos/profile/edgycomp/zcrt/collect/xd/
# sleep 1 && killall -USR1 /usr/local/bin/st &
# wait
pywalfox update & 
zathura-pywal -a 0.8
pywal-discord
# wal_steam -w -d
