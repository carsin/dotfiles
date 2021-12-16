#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# INPUT
setxkbmap us & # set keyboard layout

# trackpad 
xinput --set-prop "12" "331" "0" # enable move cursor while typing
xinput --set-prop "12" "341" "0.55" # base cursor speed scale

# OUTPUT
# monitor output

# laptop screen
xrandr --output eDP-1 --auto --dpi 200 &
# center vg248qe plugged into bot left
xrandr --output DP-2 --auto --above eDP-1 --dpi 100 -r 144 &

# start window compositor
picom -f &

# start wm
exec /usr/local/bin/dwm
