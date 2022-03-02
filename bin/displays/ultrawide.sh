#!/usr/bin/sh

export LIBVA_DRIVER_NAME=nvidia
newdpi=109

# set new xresources dpi
echo "Xft.dpi: $newdpi" | xrdb -merge

   --output DP-5 --off --output eDP-1-1 --mode 2560x1600 --pos 0x1440 --rotate normal --output DP-1-1 --off --output HDMI-1-1 --off --output DP-1-2 --off --output DP-1-3 --off --output DP-1-4 --off --output DP-1-5 --off

xrandr \
    --output DP-1 --off --output DP-2 --mode 3440x1440 --pos 2120x0 --rotate normal \
    --output DP-3 --off --output DP-4 --primary --mode 2560x1440 --pos 2560x1440 --rotate normal
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
