#!/bin/sh

newdpi=96

# set new xresources dpi
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr --output eDP1 \
    --mode 2560x1600 \
    --pos 0x1080 \
    --rotate normal \
    --output DP1 --off --output DP2 --off --output DP3 --off \
    --output DP4 --primary --dpi $newdpi --rate 144.00 --mode 1920x1080 --pos 1992x0 --rotate normal \
    --output DP5 --dpi $newdpi --rate 144.00 --mode 1920x1080 --pos 3912x0 --rotate normal \
    --output HDMI1 --off --output VIRTUAL1 --off

~/bin/newpape.sh
