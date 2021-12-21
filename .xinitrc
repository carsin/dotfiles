#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then 
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do 
    [ -x "$f" ] && . "$f" 
  done 
  unset f 
fi 

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# input configuration
# set keyboard layout
setxkbmap us 

# capslock is ctrl
setxkbmap -option ctrl:nocaps

# xinput stuff
# exec ~/bin/mouse.sh &
# exec ~/bin/trackpad.sh &

# restore wallpaper and colorschemes
wal -R &

# start window compositor
picom -f &

# set dpi
xrdb -merge ~/.Xresources 
xrandr --output eDP-1 --dpi 192 

# activity watch server
aw-qt &

# start window manager
while :; do 
    ssh-agent dwm 
done 

2560*2

# exec dwm
