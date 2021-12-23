#!/bin/sh

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

# xinput stuff
exec ~/bin/mouse.sh &
exec ~/bin/trackpad.sh &

# restore wallpaper and colorschemes
wal -R

# start window compositor
picom -f &

# activity watch server
aw-qt &

# autohide xcursor
unclutter &

# set dpi
xrdb -merge ~/.Xresources 

# start window manager
while :; do 
    ssh-agent dwm 
done 

# exec dwm
