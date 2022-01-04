#!/usr/bin/sh

newdpi=110

# set new xresources dpi
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr \
    --output DP-4 \
    --primary \
    --dpi $newdpi \
    --mode 3440x1440 \
    --pos 2560x0 \
    --auto \
\
    --output eDP-1-1 \
    --dpi 196 \
    --pos 0x0 \
    --scale 1x1 \
    --mode 2560x1600

# kill apps with wrong scaling
killall /usr/lib/firefox/firefox

# restart dwm
killall dwm
