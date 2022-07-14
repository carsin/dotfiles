#!/bin/sh

# START SLOW ASS SPOTIFY NICE AND EARLY
# spotify &

# load xresources
xrdb -merge ~/.Xresources 

xrandr --auto

echo "Initializing dock configuration"
# xrandr --setprovideroutputsource modesetting NVIDIA-0
# sudo egpu-switcher switch egpu # TODO: this hangs startup because of sudo prompt. fix
. /home/carson/bin/displays/dock.sh
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

# xinput stuff
. /home/carson/bin/initmouse
. /home/carson/bin/inittrackpad

# statusbar
/home/carson/.config/suckless/bar/bar.sh &

# restore wallpaper and colorschemes
wal -R

# start window compositor
picom -f --xrender-sync-fence &

# autohide xcursor
unclutter &

playerctld daemon

# aw-qt & 
# /home/carson/bin/displays/dual2.sh

# start window manager
while :; do 
    ssh-agent dwm 
done 

# exec dwm
