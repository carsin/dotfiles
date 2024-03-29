#!/bin/sh
pkill redshift

xrandr --output eDP-1 --dpi 96 --rate 165.00 --mode 2560x1600 --pos 1080x1547 --rotate normal --rate 144.00 --output DP-1-1 --dpi 96 --mode 1920x1080 --pos 3000x467 --rate 144.00 --rotate normal --output DP-2 --off --output HDMI-1-0 --mode 1920x1080 --dpi 96  --pos 0x0 --rotate right --output DP-1-0 --off --output DP-1 --mode 1920x1080 --primary --dpi 96 --rate 144.00 --pos 1080x467 --rotate normal --output DP-1-2 --off 
echo "Xft.dpi: 96" | xrdb -override
xinput --set-prop 'ASUE120D:00 04F3:31FB Touchpad' "Synaptics Finger" 50 80 255

exec ~/.local/bin/newpape.sh
