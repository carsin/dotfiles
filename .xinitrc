#!/bin/sh

# START SLOW ASS SPOTIFY NICE AND EARLY
# spotify &

# load xresources
xrdb -merge ~/.Xresources 

xrandr --auto
xrandr --dpi 170

# echo "Initializing triple monitor configuration"
# xrandr --setprovideroutputsource modesetting NVIDIA-0
# . /home/carson/bin/displays/triple.sh
xset -dpms

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
# key repeat
xset r rate 160 55

# no screen blanking
xset s off

# statusbar
/home/carson/.config/suckless/bar/bar.sh &

# restore wallpaper and colorschemes
wal -R

# start window compositor
picom &

# autohide xcursor
unclutter &

playerctld daemon

# aw-qt & 

# start window manager
while :; do 
   ssh-agent dwm 
done 

# exec dwm
