#!/bin/bash
# enable laptop gpu if disabled
MODE=$(supergfxctl -g)
if [[ "$MODE" == "integrated" ]]; then
    supergfxctl -m hybrid && exit
fi

asusctl profile -P balanced # enter higher power mode
asusctl -c 80               # only charge to 80% battery

# set proper dpi for monitors
newdpi=109
echo "Xft.dpi: $newdpi" | xrdb -merge

# setup monitor layout
# slo
xrandr --output DP-0 --mode 2560x1600 --pos 0x1440 --dpi $newdpi --rate 165.00 --rotate normal --output DP-1-2 --mode 3440x1440 --dpi $newdpi --rate 60.00 --pos 2120x0 --rotate normal --output DP-1 --off --output HDMI-0 --mode 2560x1440 --pos 2560x1440 --primary --rate 165.00 --rotate normal --output DP-1-0 --off --output DP-1-2 --off

# home
# xrandr --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate right --output DP-0 --mode 2560x1600 --pos 1080x1550 --rate 165.00 --rotate normal --output DP-1 --primary --mode 1920x1080 --rate 144.00 --pos 1080x470 --rotate normal --output DP-2 --off --output DP-1-1 --mode 1920x1080 --pos 3000x470 --rate 144.00 --rotate normal --output DP-1-2 --off
xset s 36000 36000 # blank screen after 1 hour
# fix wallpaper
exec ~/.local/bin/newpape.sh
