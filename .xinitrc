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
xinput --set-prop "12" "341" "0.52" # base cursor speed scale


# OUTPUT
# configure monitor output
xrandr --output eDP-1 --dpi 200 --panning 2560x1600 &

# start window compositor
picom -f &

# start wm
exec /usr/local/bin/dwm
