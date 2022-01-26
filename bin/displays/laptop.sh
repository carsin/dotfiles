#!/usr/bin/bash

# export LIBVA_DRIVER_NAME=iHD

# set new xresources dpi
newdpi=220
echo "Xf9.dpi: $newdpi" | xrdb -merge

xrandr --output eDP1 --auto --primary --dpi $newdpi 
       
# kill apps with incorrect scaling
killall /usr/lib/firefox/firefox &

exec ~/bin/autobrightness

# restart dwm
killall dwm
