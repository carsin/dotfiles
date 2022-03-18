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

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "↓ %4sB ↑ %4sB" "$(numfmt --to=iec "$rx")" "$(numfmt --to=iec "$tx")"
    fi
    printf "%s" "$SEP2"
}

dwm_network
