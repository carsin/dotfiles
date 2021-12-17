#!/usr/bin/sh

# set new xresources dpi
echo "Xft.dpi: 92" | xrdb -merge

xrandr \
    --output eDP-1 --off \
\
    --output DP-4 \
    --primary \
    --dpi 92 \
    --rate 144.00 \
    --pos 0x0 \
    --scale 1x1 \
    --mode 1920x1080 \
\
    --output DP-5 \
    --dpi 92 \
    --rate 144.00 \
    --scale 1x1 \
    --pos 1920x0  \
    --mode 1920x1080

# restart dwm
killall dwm
