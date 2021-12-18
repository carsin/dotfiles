#!/usr/bin/sh

# set new xresources dpi
echo "Xft.dpi: 192" | xrdb -merge

xrandr \
    --output eDP-1 \
    --dpi 192 \
    --mode 2560x1600 \
    --pos 0x0 \
\
    --output DP-4 \
    --dpi 192 \
    --primary \
    --mode 1920x1080 \
    --transform 2,0,0,0,2,0,0,0,1 \
    --pos 2560x0 \
\
    --output DP-5 \
    --dpi 192 \
    --mode 1920x1080 \
    --transform 2,0,0,0,2,0,0,0,1 \
    --pos 6400x0 

# kill apps with wrong scaling
killall /usr/lib/firefox/firefox

# restart dwm
killall dwm
