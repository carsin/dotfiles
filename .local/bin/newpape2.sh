#!/usr/bin/bash

clear

# TODO; RENAME NEWPAPES to differentiate ultrawide & laptop
timeout 2 wal -a 80 --backend haishoku -i ~/files/photos/papes/wal/ & 
# sleep 1 && killall -USR1 /usr/local/bin/st &
wait
pywalfox update & # may be causing instability
zathura-pywal -a 0.80
pywal-discord
wal_steam -w -d
