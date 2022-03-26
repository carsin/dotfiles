#!/bin/sh

# A dwm_bar function to read the battery level and status
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_battery () {
    CHARGE=$(acpi | awk '{ print $4 }' | tr -d \,)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    if [[ "$STATUS" != "Full" ]]; then
        printf "%s" "$SEP1"
        if [ "$IDENTIFIER" = "unicode" ]; then
            if [ "$STATUS" = "Charging" ]; then
                printf " %s" "$CHARGE" 
            else
                printf " %s" "$CHARGE" 
            fi
        fi
        printf "%s" "$SEP2 "
    fi
}

dwm_battery

