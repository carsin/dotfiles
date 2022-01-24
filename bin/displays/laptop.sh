#!/usr/bin/bash

# export LIBVA_DRIVER_NAME=iHD

# set new xresources dpi
newdpi=196
echo "Xf9.dpi: $newdpi" | xrdb -merge

xrandr --output eDP-1-1 --auto --primary \
       --dpi $newdpi \
       
# kill apps with incorrect scaling
# killall /usr/lib/firefox/firefox &

exec ~/bin/autobrightness

# restart dwm
# killall dwm
