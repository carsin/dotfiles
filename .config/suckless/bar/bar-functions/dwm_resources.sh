#!/bin/bash

dwm_resources() {
    # get all the infos first to avoid high resources usage
    free_output=$(free -h | grep Mem)
    # Used and total memory
    MEMUSED=$(echo "$free_output" | awk '{print $3}' | rev | cut -c 2- | rev)
    # MEMTOT=$(echo "$free_output" | awk '{print $2}')
    # CPU usage
    CPU=$(top -bn1 | grep Cpu | awk '{print $2}')%
    TEMP=$(sensors | grep -oP 'Package.*?\+\K[0-9.]+')
    BATSTATUS=$(cat /sys/class/power_supply/BAT0/status)
    CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
    MODE=$(asusctl profile -p | cut -d " " -f 4)
    if [ "$TEMP" = "" ]; then
        TEMP=$(sensors | grep -oP 'Physical.*?\+\K[0-9.]+')
    fi
    printf "%s" "$SEP1"
    # cpu info & memory  ﬙
    printf "%s %s° %s" "$CPU" "$(echo "$TEMP" | cut -f1 -d'.')" "$MEMUSED"
    # battery
    if [[ "$CHARGE" != "100" ]]; then
        if [ "$IDENTIFIER" = "unicode" ]; then
            if [ "$BATSTATUS" = "Charging" ]; then
                printf " %s%%" "$CHARGE" 
            else 
                printf " %s%%" "$CHARGE" 
            fi
        fi
    fi
    # laptop mode
    if [[ "$MODE" == "Quiet" ]]; then
        printf " "
    elif [[ "$MODE" == "Balanced" ]]; then
        printf " 𢡄"
    elif [[ "$MODE" == "Performance" ]]; then
        printf " 龍"
    fi
    printf "%s" "$SEP2"
}

dwm_resources
