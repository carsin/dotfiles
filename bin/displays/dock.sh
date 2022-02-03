#!/usr/bin/sh

export LIBVA_DRIVER_NAME=nvidia
newdpi=109

echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr --output DP-1 --off --output DP-2 --mode 3440x1440 --pos 2560x160 --rotate normal --dpi $newdpi  \
--output DP-4 --primary --mode 2560x1440 --pos 3000x1600 --rotate normal --dpi $newdpi --rate 165.00 \
--output eDP-1-1 --mode 2560x1600 --pos 0x0 --rotate normal 

