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
    # toggle anim
    # if [ "$TOG" == 1 ]; then
    #     UP_ICON='↑'
    #     DOWN_ICON='↓'
    # elif [[ "$TOG" == 0 ]]; then
    #     UP_ICON='▲'
    #     DOWN_ICON='▼'
    # fi

    # change based on hour
    if [ "$(($(date +'%H') % 2))" -eq 0 ]; then
        UP_ICON='▲'
        DOWN_ICON='▼'
    else
        UP_ICON='↑'
        DOWN_ICON='↓'
    fi

    if [ "$tx" = '0' ]; then
        if [ "$TOG" == 1 ]; then
            UP_ICON='•'
        elif [[ "$TOG" == 0 ]]; then
            UP_ICON='∙'
        fi
    fi
    if [ "$rx" = '0' ]; then
        if [ $((TOG % 2)) -eq 0 ]; then
            DOWN_ICON='•'
        else
            DOWN_ICON='∙'
        fi
    fi

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        # printf "%s%4sB %s%4sB" "$DOWN_ICON" "$(numfmt --to=iec "$rx")" "$UP_ICON" "$(numfmt --to=iec "$tx")"
        printf "%4s %s %4s %s" "$(numfmt --to=iec "$rx")" "$DOWN_ICON" "$(numfmt --to=iec "$tx")" "$UP_ICON"
    fi
    printf "%s" "$SEP2"
}

dwm_network
