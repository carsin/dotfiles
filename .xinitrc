#!/bin/sh
# start laptop in quiet mode
asusctl profile -P quiet

# load xresources
xrdb -merge ~/.Xresources 

xrandr --auto
xrandr --dpi 170

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then 
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do 
    [ -x "$f" ] && . "$f" 
  done 
  unset f 
fi 

# input configuration
echo b | xclip -sel c
# capslock is ctrl
setxkbmap -option ctrl:nocaps
# key repeat
xset r rate 147 52
xinput --set-prop 'ASUE120D:00 04F3:31FB Touchpad' "libinput Accel Speed" 0.176
xinput --set-prop 'ASUE120D:00 04F3:31FB Touchpad' "libinput Disable While Typing Enabled" 0 # don't disable pad while typing

# set brightness lower
brightnessctl s 13%

# no screen blanking
xset s 36000 36000 # blank screen after 1 hour

/home/carson/.config/suckless/bar/bar.sh & # statusbar
wal -R # restore wallpaper and colorschemes
picom & # start window compositor
unclutter & # autohide xcursor
playerctld daemon # audio control
easyeffects --gapplication-service & # audio tuning
# asusctl -c 100 # only charge to 80% battery

# start window manager
while :; do 
   ssh-agent dwm 
done 

# exec dwm
