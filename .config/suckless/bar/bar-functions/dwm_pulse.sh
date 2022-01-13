#!/bin/sh

# A dwm_bar function to show the master volume of PulseAudio
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: pamixer

dwm_pulse () {
    VOL=$(pulsemixer --get-volume | cut -d ' ' -f 2)
    STATE=$(pulsemixer --get-mute)
    
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$STATE" = "true" ] || [ "$VOL" -eq 0 ]; then
            printf "婢"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "奔 %s%%" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "墳%s%%" "$VOL"
        else
            printf " %s%%" "$VOL"
        fi
    else
        if [ "$STATE" = "true" ] || [ "$VOL" -eq 0 ]; then
            printf "MUTE"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "VOL %s%%" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "VOL %s%%" "$VOL"
        else
            printf "VOL %s%%" "$VOL"
        fi
    fi
    printf "%s\n" "$SEP2"
}

dwm_pulse
