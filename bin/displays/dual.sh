#!/usr/bin/sh

# set up displays
# xrandr --output eDP-1 --off \
#        --output DP-4 --auto --rate 144.0 --primary \
#        --output DP-5 --auto --rate 144.0 --right-of DP-4

xrandr \
    --output eDP-1 --off \
\
    --output DP-4 \
    --dpi 192 \
    --primary \
    --mode 1920x1080 \
    --transform 2,0,0,0,2,0,0,0,1 \
    --pos 0x0 \
\
    --output DP-5 \
    --dpi 192 \
    --mode 1920x1080 \
    --transform 2,0,0,0,2,0,0,0,1 \
    --pos 3840x0 
