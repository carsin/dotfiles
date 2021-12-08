#!/usr/bin/env bash

. ~/.cache/wal/colors.sh
BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ $CHARGING != "" ]]; then
    if [[ $BATT_PERCENT -ge 99 ]] && [[ $BATT_PERCENT -le 100 ]]; then
        sketchybar -m --set battery icon= \
                                    label= \
                                    label.padding_left=0 \
                                    icon.padding_left=0 \
                                    icon.padding_right=0 
        exit 0
    fi
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%") \
                                label.padding_left=2 \
                                icon.padding_left=6 \
                                icon.padding_right=2 
    exit 0
else
    sketchybar -m --set battery label.padding_left=2 \
                                icon.padding_left=6 \
                                icon.padding_right=2 
fi

if [[ $BATT_PERCENT -ge 0 ]] && [[ $BATT_PERCENT -le 10 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%") 
elif [[ $BATT_PERCENT -ge 11 ]] && [[ $BATT_PERCENT -le 20 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%") 
elif [[ $BATT_PERCENT -ge 21 ]] && [[ $BATT_PERCENT -le 30 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%")
elif [[ $BATT_PERCENT -ge 31 ]] && [[ $BATT_PERCENT -le 40 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%")
elif [[ $BATT_PERCENT -ge 41 ]] && [[ $BATT_PERCENT -le 50 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%")
elif [[ $BATT_PERCENT -ge 51 ]] && [[ $BATT_PERCENT -le 60 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%")
elif [[ $BATT_PERCENT -ge 61 ]] && [[ $BATT_PERCENT -le 70 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%")
elif [[ $BATT_PERCENT -ge 71 ]] && [[ $BATT_PERCENT -le 80 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%")
elif [[ $BATT_PERCENT -ge 81 ]] && [[ $BATT_PERCENT -le 90 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%")
elif [[ $BATT_PERCENT -ge 91 ]] && [[ $BATT_PERCENT -le 100 ]]; then
    sketchybar -m --set battery icon= \
                                label=$(printf "${BATT_PERCENT}%%")
fi

exit 0
