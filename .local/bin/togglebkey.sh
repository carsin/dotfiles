#!/bin/bash
KEYVAL=$(xmodmap -pke | grep 'keycode  56 =')
if [[ $KEYVAL == "keycode  56 =" ]]; then
    notify-send "b key enabled."
    xmodmap -e 'keycode  56= b B b B'
else
    notify-send "b key disabled."
    xmodmap -e 'keycode  56='
fi
