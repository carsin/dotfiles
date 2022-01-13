#!/bin/sh

# A dwm_bar function to read the battery level and status
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_battery () {
    CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    if [[ "$STATUS" != "Full" ]]; then
        printf "%s" "$SEP1"
        if [ "$IDENTIFIER" = "unicode" ]; then
            if [ "$STATUS" = "Charging" ]; then
                printf " %s%% %s" "$CHARGE" "$STATUS"
            else
                printf " %s%% %s" "$CHARGE" "$STATUS"
            fi
        else
            printf "BAT %s%% %s" "$CHARGE" "$STATUS"
        fi
        printf "%s\n" "$SEP2"
    fi
}

dwm_battery
