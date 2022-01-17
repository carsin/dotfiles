#!/usr/bin/bash
sudo -v

# set new xresources dpi
newdpi=196
echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr --output eDP-1-1 --auto --primary \
       --dpi $newdpi \
       
# kill apps with incorrect scaling
# killall /usr/lib/firefox/firefox &

exec sudo ~/bin/autobrightness.sh 

# restart dwm
# killall dwm
