#!/usr/bin/bash
sudo -v

# set new xresources dpi
newdpi=170
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr --output eDP-1-1 --auto --primary \
       --dpi $newdpi \
       --output DP-4 --off \
       --output DP-5 --off

# kill apps with incorrect scaling
killall /usr/lib/firefox/firefox &

exec sudo ~/bin/autobrightness.sh 

# restart dwm
killall dwm
