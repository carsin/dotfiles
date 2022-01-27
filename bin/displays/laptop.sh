#!/usr/bin/bash

# sudo egpu-switcher switch internal

# set new xresources dpi
newdpi=166
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr --output eDP1 --auto --primary --dpi $newdpi 

~/bin/autobrightness
       
# kill apps with incorrect scaling
killall /usr/lib/firefox/firefox 

# restart dwm
pkill dwm
