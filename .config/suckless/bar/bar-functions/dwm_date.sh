#!/bin/bash

dwm_date() {
    # different anims based on hour
    if [ "$(($(date +'%-H') % 2))" == 0 ]; then
        # anim 1: subtle flutter
        if [ "$TOG" == 1 ]; then
            ICON=":"
            ICON2="/"
        elif [[ "$TOG" == 2 ]]; then
            ICON="-"
            ICON2="/"
        elif [[ "$TOG" == 3 ]]; then
            ICON=":"
            ICON2="-"
        elif [[ "$TOG" == 4 ]]; then
            ICON="-"
            ICON2="-"
        elif [[ "$TOG" -ge 4 ]]; then
            TOG=1
            dwm_date
            return
        fi
    else
        # anim 2: buildup and release
        if [ "$TOG" == 1 ]; then
            ICON=" "
            ICON2=" "
        elif [[ "$TOG" == 2 ]]; then
            ICON=":"
            ICON2="/"
        elif [[ "$TOG" == 3 ]]; then
            ICON=":"
            ICON2="-"
        elif [[ "$TOG" == 4 ]]; then
            ICON="-"
            ICON2="/"
        elif [[ "$TOG" == 5 ]]; then
            ICON=":"
            ICON2="-"
        elif [[ "$TOG" == 6 ]]; then
            ICON="-"
            ICON2="-"
        fi
    fi
    DATESTR="$(date '+%-I:%M:%S %p %-m/%-d/%Y %a ')"
    DATESTR=$(echo "$DATESTR" | tr : "$ICON" | tr / "$ICON2")
    printf "%s" "$DATESTR"
    # percentage of day complete
    # DAYPERCENT=$(echo "($(date -d "1970-01-01 UTC $(date +%T)" +%s)/86400)*100" | bc -l | sed 's/\..*//')
    DAYPERCENT=$(echo "($(date -d "1970-01-01 UTC $(date +%T)" +%s)/86400)*100" | bc -l)
    if [ "$DAYPERCENT" = "" ]; then
        DAYPERCENT=0
    fi
    if [ "$TOG" == 5 ]; then
        printf "%0.5s%%" "$DAYPERCENT"
    else
        printf "%0.4s%%" "$DAYPERCENT"
    fi
}

dwm_date
