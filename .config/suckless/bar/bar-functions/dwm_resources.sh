#!/bin/bash

dwm_resources() {
    # get all the infos first to avoid high resources usage
    free_output=$(free -h | grep Mem)
    # Used and total memory
    MEMUSED=$(echo "$free_output" | awk '{print $3}' | rev | cut -c 2- | rev)
    MEMTOT=$(echo "$free_output" | awk '{print $2}')
    # CPU usage
    CPU=$(top -bn1 | grep Cpu | awk '{print $2}')%
    TEMP=$(sensors | grep -oP 'Package.*?\+\K[0-9.]+')
    if [ "$TEMP" = "" ]; then
        TEMP=$(sensors | grep -oP 'Physical.*?\+\K[0-9.]+')
    fi

    printf "%s" "$SEP1"
    # ﬙
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf " %s %s° ﬙ %s" "$CPU" "$TEMP" "$MEMUSED"
    fi
    printf "%s" "$SEP2"
}

dwm_resources
