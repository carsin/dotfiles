#!/usr/bin/bash

echo "Choosing new pape"
wal -a 90 -i ~/files/photos/wallpapers/wal &
wait
echo "Finished, reloading env"
pywalfox update &
killall -USR1 st &
