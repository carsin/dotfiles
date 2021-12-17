#!/usr/bin/bash

# set up displays
xrandr --output eDP-1 --off \
       --output DP-4 --auto --dpi 92 --rate 144.0 --primary \
       --output DP-5 --auto --dpi 92 --rate 144.0 --right-of DP-4
