#!/usr/bin/bash

# sudo egpu-switcher switch internal

# set new xresources dpi
# font 14: 196; font 13: 167
newdpi=167
echo "Xft.dpi: $newdpi" | xrdb -merge


xrandr --output eDP1 --auto --primary --dpi $newdpi 

# set kbd backlight
echo 15 > /sys/class/leds/apple::kbd_backlight/brightness

# set screen brightness based on ambient light
# ~/bin/autobrightness
bright 20
       
# kill apps with incorrect scaling
killall firefox 
killall chromium

# restart dwm
pkill dwm










































