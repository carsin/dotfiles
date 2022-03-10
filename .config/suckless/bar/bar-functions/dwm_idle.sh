#!/bin/bash

dwm_idle () {
   IDLE=$(xprintidle)
    if [ "$IDLE" -ge 15000 ]; then
        if [ "$TOG" == 1 ]; then
            ICON="羽"
        elif [[ "$TOG" == 0 ]]; then
            ICON="ﮫ"
        fi
        
        #  TODO: icon animation
        SECS=$((IDLE/1000))
        printf "%s%s %ss%s " "$SEP1" "$ICON" "$SECS" "$SEP2" 
    fi
}

dwm_idle
