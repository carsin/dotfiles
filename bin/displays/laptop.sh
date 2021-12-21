#!/usr/bin/bash

# set new xresources dpi
newdpi=180
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr --dpi $newdpi \
       --output eDP-1 --auto --primary \
       --output DP-4 --off \
       --output DP-5 --off

# kill apps with incorrect scaling
killall /usr/lib/firefox/firefox &

exec ~/bin/autobrightness.sh 

# restart dwm
killall dwm
