#!/bin/bash

dwm_idle() {
    IDLE=$(xprintidle)
    if [ "$IDLE" -ge 30000 ]; then
        # simple anim
        # if [ $((TOG % 2)) -eq 0 ]; then
        #     ICON="羽"
        # else
        #     ICON="ﮫ"
        # fi

        # TODO: extend to 8 
        if [ "$TOG" == 1 ]; then
            ICON="┤"
        elif [[ "$TOG" == 2 ]]; then
            ICON="┘"
        elif [[ "$TOG" == 3 ]]; then
            ICON="┴"
        elif [[ "$TOG" == 4 ]]; then
            ICON="└"
        elif [[ "$TOG" == 5 ]]; then
            ICON="├"
        elif [[ "$TOG" == 6 ]]; then
            ICON="┬"
        fi

        #  TODO: icon animation
        i=$((IDLE / 1000))
        ((sec = i % 60, i /= 60, min = i % 60, hrs = i / 60))
        if [[ i -ge 3600 ]]; then
            printf "%s " "$ICON"
            printf "%dh %dm %ds" $hrs $min $sec
            printf "%s" "$SEC2"
        elif [[ i -ge 60 ]]; then
            printf "%s " "$ICON"
            printf "%dm %ds" $min $sec
            printf "%s" "$SEC2"
        else
            printf "%s %ds%s " "$ICON" "$sec" "$SEP2"
        fi
    fi
}

dwm_idle

# idleloop() {
#     touch /tmp/.{,last_}input
#     cmd='stat --printf="%s"'
#     idletime=120
#     a=2
#     t=0
#     while true
#     do
#         timeout 1 xinput test-xi2 --root > /tmp/.input
#
#         if [[ `eval "$cmd" /tmp/.input` == `eval "$cmd" /tmp/.last_input` ]]
#         then
#             let t++ # increases $t by 1
#         else
#             t=0     # resets $t
#         fi
#
#         mv /tmp/.{,last_}input -f
#
#         if [ "$t" -ge "$idletime" ] && [[ $a == "2" ]]
#         then
#             echo "user has gone idle"
#             a=1
#         fi
#         if [ "$t" -lt "$idletime" ] && [[ $a == "1" ]]
#         then
#             echo "user has come back from idle"
#             a=2
#         fi
#     done
# }
#
# # idleloop &
