#!/bin/bash

dwm_network() {
    # calculate network i/o
    update() {
        sum=0
        for arg; do
            read -r i <"$arg"
            sum=$((sum + i))
        done
        cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
        [ -f "$cache" ] && read -r old <"$cache" || old=0
        printf %d\\n "$sum" >"$cache"
        printf %d\\n $((sum - old))
    }
    rx=$(update /sys/class/net/[ew]*/statistics/rx_bytes)
    tx=$(update /sys/class/net/[ew]*/statistics/tx_bytes)
    UP_ICON='↑ '
    DOWN_ICON='↓ '
    if [ "$tx" = '0' ]; then
        UP_ICON=''
    fi
    if [ "$rx" = '0' ]; then
        DOWN_ICON=''
    fi

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        # printf "%s%4sB %s%4sB" "$DOWN_ICON" "$(numfmt --to=iec "$rx")" "$UP_ICON" "$(numfmt --to=iec "$tx")"
        printf "%s%4s %s%4s" "$DOWN_ICON" "$(numfmt --to=iec "$rx")" "$UP_ICON" "$(numfmt --to=iec "$tx")"
    fi
    printf "%s" "$SEP2"
}

dwm_network
