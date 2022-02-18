#!/bin/sh

dwm_pomo () {
   POMO=$(pomo -p /home/carson/.config/pomo/config.json st)
    if [ "$POMO" != "? [0/0] -" ]; then
        printf "%s%s%s" "$SEP1" "$POMO" "$SEP2" 
    fi
}

dwm_pomo
