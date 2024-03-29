#!/bin/bash

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
TOG=1
export IDENTIFIER="unicode"
export SEP1=""
export SEP2=" │"

# Import the modules
. "$DIR/bar-functions/dwm_idle.sh"
. "$DIR/bar-functions/dwm_spotify.sh"
. "$DIR/bar-functions/dwm_network.sh"
. "$DIR/bar-functions/dwm_resources.sh"
# . "$DIR/bar-functions/dwm_battery.sh"
. "$DIR/bar-functions/dwm_pomo.sh"
. "$DIR/bar-functions/dwm_weather.sh"
. "$DIR/bar-functions/dwm_date.sh"

# TODO: fix weather only updating on initial run
# parallelize() {
#     while true;
#     do
#         # printf "running parallel processes\n"
#         dwm_weather &
#         sleep 20
#     done
# }
# parallelize &

while true; do
    if [ "$TOG" -lt 6 ]; then # TODO: extend to 8 
        TOG=$((TOG + 1))
        export TOG
    else
        export TOG
        TOG=1
    fi
    upperbar=""
    upperbar="$upperbar$(dwm_idle)"
    upperbar="$upperbar$(dwm_pomo)"
    upperbar="$upperbar$(dwm_spotify)"
    upperbar="$upperbar$(dwm_network) "
    upperbar="$upperbar$(dwm_resources) "
    # upperbar="$upperbar$(dwm_battery)"
    # WEATHER=${__DWM_BAR_WEATHER__/${__DWM_BAR_WEATHER__:1:2}/} # strip broken char
    # WEATHER=$(echo "$WEATHER" | tr -d F+) # remove fahrenheight&+ indicator chars
    # if [ "$WEATHER" != "" ]; then
    #     upperbar="$upperbar$WEATHER"
    # fi
    # upperbar="$upperbar$__DWM_BAR_WEATHER__"
    upperbar="$upperbar$(dwm_date)"
    xsetroot -name "$upperbar"
    sleep 2
done
