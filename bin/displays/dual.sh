#!/usr/bin/bash

# set up displays
# xrandr --output eDP-1 --off \
#        --output DP-4 --auto --rate 144.0 --primary \
#        --output DP-5 --auto --rate 144.0 --right-of DP-4

xrandr \
  --output DP-4 \
  --primary \
  --rate 144.0 \
  --mode 1920x1080 \
  --fb 7680x5760 \
  --rotate normal \
  --scale 1.5x1.5 \
  --panning 5760x3240+0+0 \
\
  --output DP-5 \
  --rate 144.0 \
  --rotate normal \
  --mode 1920x1080 \
  --right-of DP-4 \
  --fb 7680x2160 \
  --scale 1.5x1.5 \
  --panning 5760x3240+5760+0 \
\
  --output eDP-1 --off
  
# triple testing
# xrandr \
#   --output DP-4 \
#   --primary \
#   --mode 3840x2160 \
#   --fb 10240x5760 \
#   --rotate normal \
#   --scale 1.5x1.5 \
#   --panning 5760x3240+0+0 \
# \
#   --output DP-5 \
#   --rotate normal \
#   --mode 3840x2160 \
#   --right-of DP-4 \
#   --fb 10240x2160   \
#   --scale 1.5x1.5 \
#   --panning 5760x3240+5760+0 \
# \
#   --output eDP-1 \
#   --mode 2560x1600
#   --rotate normal \
#   --fb 10240x2160   \
#   --scale 1.5x1.5 \
#   --panning 5760x3240+5760+0 \
