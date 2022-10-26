#!/bin/bash
MODE=$(supergfxctl -g)

if [[ "$MODE" == "integrated" ]]; then
    supergfxctl -m hybrid && exit
fi

newdpi=109

echo "Xft.dpi: $newdpi" | xrdb -merge

xrandr --output eDP-1 --mode 2560x1600 --pos 0x1440 --dpi $newdpi --rate 165.00 --rotate normal --output DP-1-1 --mode 3440x1440 --dpi $newdpi --rate 60.00 --pos 2120x0 --rotate normal --output DP-2 --off --output HDMI-1-0 --mode 2560x1440 --pos 2560x1440 --primary --rate 165.00 --rotate normal --output DP-1-0 --off --output DP-1-2 --off

xinput --set-prop 'ASUE120D:00 04F3:31FB Touchpad' "Synaptics Finger" 50 80 255
exec ~/.local/bin/newpape.sh
