#!/bin/bash
# enable laptop gpu if disabled
MODE=$(supergfxctl -g)
if [[ "$MODE" == "integrated" ]]; then
    supergfxctl -m hybrid && exit
fi

asusctl profile -P balanced # enter higher power mode

# set proper dpi for monitors
newdpi=109
echo "Xft.dpi: $newdpi" | xrdb -merge

# setup monitor layout
xrandr --output eDP-1 --mode 2560x1600 --pos 0x1440 --dpi $newdpi --rate 165.00 --rotate normal --output DP-1-1 --mode 3440x1440 --dpi $newdpi --rate 60.00 --pos 2120x0 --rotate normal --output DP-2 --off --output HDMI-1-0 --mode 2560x1440 --pos 2560x1440 --primary --rate 165.00 --rotate normal --output DP-1-0 --off --output DP-1-2 --off

xset s 3600 3600 # blank screen after 1 hour

# fix wallpaper
exec ~/.local/bin/newpape.sh
