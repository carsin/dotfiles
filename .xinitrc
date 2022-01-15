#!/bin/sh

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then 
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do 
    [ -x "$f" ] && . "$f" 
  done 
  unset f 
fi 

# xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
. /home/carson/bin/displays/ultrawide.sh

# input configuration
# capslock is ctrl
setxkbmap -option ctrl:nocaps

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

spotify &

# load xresources
xrdb -merge ~/.Xresources 

# start window manager
while :; do 
    ssh-agent dwm 
done 

# exec dwm
