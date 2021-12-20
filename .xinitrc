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

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# input configuration
setxkbmap us & # set keyboard layout
# capslock is ctrl
setxkbmap -option ctrl:nocaps
# xinput stuff
exec ~/bin/mouse.sh &
#xec ~/bin/trackpad.sh &

# restore wallpaper and colorschemes
wal -R

# start window compositor
picom -f &

# start window manager
# exec ~/bin/dwmloop.sh
exec dwm
