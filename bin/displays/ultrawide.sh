#!/usr/bin/sh

newdpi=110

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
