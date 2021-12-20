#!/usr/bin/bash

# set new xresources dpi
echo "Xft.dpi: 192" | xrdb -merge

xrandr --dpi 192 \
       --output eDP-1 --auto --primary \
       --output DP-4 --off \
       --output DP-5 --off

# kill apps with incorrect scaling
killall /usr/lib/firefox/firefox &

exec ~/bin/autobrightness.sh &

# restart dwm
killall dwm
