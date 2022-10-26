#!/bin/sh

# start in quiet mode
asusctl profile -P quiet
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
# libinput touchpad
xinput --set-prop 'ASUE120D:00 04F3:31FB Touchpad' "libinput Accel Speed" 0.176

# no screen blanking
xset s off

/home/carson/.config/suckless/bar/bar.sh & # statusbar
wal -R # restore wallpaper and colorschemes
picom & # start window compositor
unclutter & # autohide xcursor
playerctld daemon # audio control
easyeffects --gapplication-service & # audio tuning
asusctltray # laptop power control tray widget

# start window manager
while :; do 
   ssh-agent dwm 
done 

# exec dwm
