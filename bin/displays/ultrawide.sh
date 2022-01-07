#!/usr/bin/sh

newdpi=96

# set new xresources dpi
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr \
    --output DP-1-3 \
    --primary \
    --dpi $newdpi \
    --mode 3440x1440 \
    --right-of eDP-1-1 \
    --auto \
\
    --output eDP-1-1 \
    --auto
    --dpi 196 \
    --pos 0x0 \
    --scale 1.25x1.25 \
    --panning 2560x1600

# kill apps with wrong scaling
killall /usr/lib/firefox/firefox

# restart dwm
killall dwm

