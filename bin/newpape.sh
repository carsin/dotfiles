#!/bin/sh

clear

# TODO; RENAME NEWPAPES to differentiate ultrawide & laptop
if [ "$1" = "-i" ]; then
    echo "going thro dir iterative"
    timeout 2 wal -a 80 --backend haishoku --iterative -i ~/files/photos/papes/ultrawide &
else
    timeout 2 wal -a 80 --backend haishoku -i ~/files/photos/papes/ultrawide & 
fi 
# sleep 1 && killall -USR1 /usr/local/bin/st &
wait
pywalfox update & # may be causing instability
zathura-pywal -a 0.80 &
pywal-discord
wal_steam -w -d
