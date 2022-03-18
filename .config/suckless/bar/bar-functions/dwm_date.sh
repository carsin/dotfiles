#!/bin/bash

dwm_date() {
    printf "%s" "$SEP1"
    if [ "$TOG" == 1 ]; then
        ICON=":"
    elif [[ "$TOG" == 0 ]]; then
        ICON=" "
    fi
    DATESTR="$(date "+%-I:%M:%S %p %-m/%-d/%y %a ")"
    DATESTR=$(echo "$DATESTR" | tr : "$ICON")
    printf " %s" "$DATESTR"
    # percentage of day complete
    DAYPERCENT=$(echo "($(date -d "1970-01-01 UTC $(date +%T)" +%s)/86400)*100" | bc -l | sed 's/\..*//')
    if [ "$DAYPERCENT" = "" ]; then
        DAYPERCENT=0
    fi
    printf "%s%%" "$DAYPERCENT"
}

dwm_date
