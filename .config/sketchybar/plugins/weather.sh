#!/usr/bin/env bash

status=$(curl -s 'wttr.in/96754?format=%C+|+%t')

condition=$(echo $status | awk -F '|' '{print $1}' | tr '[:upper:]' '[:lower:]')
condition="${condition// /}"
temp=$(echo $status | awk -F '|' '{print $2}')
temp="${temp//\+/}"
temp="${temp// /}"

# add more conditions here as appropriate
case "${condition}" in
    "sunny")
        icon=""
        ;;
    "partlycloudy")
        icon=" "
        ;;
    "lightrain")
        icon=""
        ;;
    "overcast")
        icon=""
        ;;
    *)
        icon="$condition"
        ;;
esac

sketchybar -m set weather icon "$icon"
sketchybar -m set weather label "$temp"
