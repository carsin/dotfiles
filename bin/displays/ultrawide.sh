#!/usr/bin/sh

export LIBVA_DRIVER_NAME=nvidia
newdpi=109

# set new xresources dpi
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr \
    --output DP-4 \
    --primary \
    --dpi $newdpi \
    --auto \
    --right-of eDP-1-1 \
\
    --output eDP-1-1 \
    --dpi 196 \
    --auto \
    --pos 0x0

# kill apps with wrong scaling
killall /usr/lib/firefox/firefox
killall st
