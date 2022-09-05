#!/bin/bash

dwm_battery () {
    CHARGE=$(acpi | awk '{ print $4 }' | tr -d \,)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    if [[ "$STATUS" != "Full" ]]; then
        # printf "%s" "$SEP1"
        if [ "$IDENTIFIER" = "unicode" ]; then
            if [ "$STATUS" = "Charging" ]; then
                printf " %s" "$CHARGE" 
            else
                printf " %s" "$CHARGE" 
            fi
        fi
        # printf "%s" "$SEP2 "
    fi
}

dwm_resources() {
    # get all the infos first to avoid high resources usage
    free_output=$(free -h | grep Mem)
    # Used and total memory
    MEMUSED=$(echo "$free_output" | awk '{print $3}' | rev | cut -c 2- | rev)
    # MEMTOT=$(echo "$free_output" | awk '{print $2}')
    # CPU usage
    CPU=$(top -bn1 | grep Cpu | awk '{print $2}')%
    TEMP=$(sensors | grep -oP 'Package.*?\+\K[0-9.]+')
    if [ "$TEMP" = "" ]; then
        TEMP=$(sensors | grep -oP 'Physical.*?\+\K[0-9.]+')
    fi
    # TEMP=${TEMP}

    printf "%s" "$SEP1"
    # ﬙
    printf "%s° %s %s " "$(echo "$TEMP" | cut -f1 -d'.')" "$CPU" "$MEMUSED"
    dwm_battery
    printf "%s" "$SEP2"
}

dwm_resources
