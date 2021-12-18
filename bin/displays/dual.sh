#!/usr/bin/sh

newdpi=92

# set new xresources dpi
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr \
    --output eDP-1 --off \
\
    --output DP-4 \
    --primary \
    --dpi $newdpi \
    --rate 144.00 \
    --pos 0x0 \
    --scale 1x1 \
    --mode 1920x1080 \
\
    --output DP-5 \
    --dpi $newdpi \
    --rate 144.00 \
    --scale 1x1 \
    --pos 1920x0  \
    --mode 1920x1080

# kill apps with wrong scaling
killall /usr/lib/firefox/firefox

# restart dwm
killall dwm
