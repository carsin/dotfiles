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

    if [ "$tx" = '0' ]; then
        if [ $((TOG % 2)) -eq 0 ]; then
            UP_ICON='•'
        else
            UP_ICON='∙'
        fi
        to=''
    else
        UP_ICON='↑'
        to="$(numfmt --to=iec "$tx") "
    fi
    if [ "$rx" = '0' ]; then
        if [ $((TOG % 2)) -eq 0 ]; then
            DOWN_ICON='•'
        else
            DOWN_ICON='∙'
        fi
        ro=''
    else
        DOWN_ICON='↓'
        ro="$(numfmt --to=iec "$rx") "
    fi

    printf "%s" "$SEP1"
    # printf "%s%4sB %s%4sB" "$DOWN_ICON" "$(numfmt --to=iec "$rx")" "$UP_ICON" "$(numfmt --to=iec "$tx")"
    printf " %s%3s %s%3s" "$ro" "$DOWN_ICON" "$to" "$UP_ICON"
    # printf "%s%s %s%s" "$ro" "$DOWN_ICON" "$to"  "$UP_ICON"
    printf "%s" "$SEP2"
}

dwm_network
