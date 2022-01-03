#!/usr/bin/sh

newdpi=110

# set new xresources dpi
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr \
    --output DP-3 \
    --primary \
    --dpi $newdpi \
    --auto \
    --right-of eDP-1 \
\
    --output eDP-1 \
    --dpi 196 \
    --auto \
    --scale 1x1 \
    --mode 2560x1600

# kill apps with wrong scaling
killall /usr/lib/firefox/firefox

# restart dwm
killall dwm
