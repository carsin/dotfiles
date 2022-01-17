#!/bin/sh

xrandr --auto

# START SLOW ASS SPOTIFY NICE AND EARLY
spotify --no-zygote &

# Load settings based on setup config
if [[ $ACTIVE_SETUP_CONFIG = "desktop" ]]; then
    echo "Initializing desktop configuration (eGPU, ultrawide monitor)"
    # xrandr --setprovideroutputsource modesetting NVIDIA-0
    egpu-switcher switch egpu
    . /home/carson/bin/displays/ultrawide.sh
    xset -dpms
elif [[ $ACTIVE_SETUP_CONFIG = "laptop" ]]; then
    echo "Initializing mobile laptop configuration (internal graphics)"
    egpu-switcher switch internal
    . /home/carson/bin/displays/laptop.sh
else
    echo "Unknown setup found ($ACTIVE_SETUP_CONFIG), defaulting to laptop"
    egpu-switcher switch internal
    . /home/carson/bin/displays/laptop.sh
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then 
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do 
    [ -x "$f" ] && . "$f" 
  done 
  unset f 
fi 

# input configuration
# capslock is ctrl
setxkbmap -option ctrl:nocaps
xset r rate 185 35 
xset s noblank

# xinput stuff
. /home/carson/bin/initmouse
. /home/carson/bin/inittrackpad

# statusbar
/home/carson/.config/suckless/bar/dwm_bar.sh &

# restore wallpaper and colorschemes
wal -R

# start window compositor
picom -f &

# activity watch server
aw-qt &

# autohide xcursor
unclutter &

# redshift
redshift &

# load xresources
xrdb -merge ~/.Xresources 

# start window manager
while :; do 
    ssh-agent dwm 
done 

# exec dwm
