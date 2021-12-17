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

# setup trackpad 

# get ID consistently (it changes when plugging other input in)
id="$(xinput list --id-only pointer:'bcm5974')"
# enable move cursor while typing
xinput --set-prop $id '331' '0'
# scale base cursor speed 
xinput --set-prop $id '341' '0.55' 

# OUTPUT
       
# start window compositor
picom -f &

# start window manager
# exec ~/bin/dwmloop.sh
exec dwm
