#!/bin/bash

dwm_spotify () {
    if ps -C spotify > /dev/null; then
        PLAYER="spotify"
    elif ps -C spotifyd > /dev/null; then
        PLAYER="spotifyd"
    elif ps -C ncspot > /dev/null; then
        PLAYER="ncspot"
    fi
    
    # TODO: extend to 8 
    # if [ "$TOG" == 1 ]; then
    #     ANIM_ICON="⣷ "
    # elif [[ "$TOG" == 2 ]]; then
    #     ANIM_ICON="⣯ "
    # elif [[ "$TOG" == 3 ]]; then
    #     ANIM_ICON="⣟ "
    # elif [[ "$TOG" == 4 ]]; then
    #     ANIM_ICON="⢿ "
    # elif [[ "$TOG" == 5 ]]; then
    #     ANIM_ICON="⣻ "
    # elif [[ "$TOG" == 6 ]]; then
    #     ANIM_ICON="⣽ "
    # fi
    
    if [ "$TOG" == 1 ]; then
        # ⬒ ⬔ ⬓ ⬕	
        # ⬖ ⬘ ⬗ ⬙	
        # ◜ ◝ ◞ ◟	
        ANIM_ICON="◜"
    elif [[ "$TOG" == 2 ]]; then
        ANIM_ICON="◝"
    elif [[ "$TOG" == 3 ]]; then
        ANIM_ICON="◞"
    elif [[ "$TOG" == 4 ]]; then
        ANIM_ICON="◟"
    elif [[ "$TOG" == 5 ]]; then
        ANIM_ICON="◞"
    elif [[ "$TOG" == 6 ]]; then
        ANIM_ICON="◝"
    fi

    if [ "$PLAYER" = "spotify" ] || [ "$PLAYER" = "spotifyd" ] || [ "$PLAYER" = "ncspot" ]; then
        # get info and shorten artist/track to 25 char
        ARTIST=$(playerctl --player="$PLAYER" metadata artist | sed 's/\(.\{25\}\).*/\1…/')
        TRACK=$(playerctl --player="$PLAYER" metadata title | sed 's/\(.\{25\}\).*/\1…/')
        
        # POSITION=$(playerctl --player="$PLAYER" position | sed 's/..\{6\}$//')
        # DURATION=$(playerctl --player="$PLAYER"metadata mpris:length | sed 's/.\{6\}$//')
        STATUS=$(playerctl --player="$PLAYER" status)
        SHUFFLE=$(playerctl shuffle)

        if [ "$IDENTIFIER" = "unicode" ]; then
            # if [ "$STATUS" = "Playing" ]; then
            #     STATUS="-"
            # else
            #     STATUS="⏸"
            # fi
            
            if [ "$SHUFFLE" = "On" ]; then
                SHUFFLE=""
            else
                SHUFFLE=""
            fi
        else
            if [ "$STATUS" = "Playing" ]; then
                STATUS="PLA"
            else
                STATUS="PAU"
            fi

            if [ "$SHUFFLE" = "On" ]; then
                SHUFFLE=" S"
            else
                SHUFFLE=""
            fi
        fi
        
        if [ "$STATUS" = "Playing" ]; then
            printf "%s%s %s %s" "$SEP1" "$ARTIST" "$ANIM_ICON" "$TRACK" 
            # printf " %0d:%02d/" $((POSITION%3600/60)) $((POSITION%60))
            # printf "%0d:%02d" $((DURATION%3600/60)) $((DURATION%60))
            printf "%s " "$SEP2"
        fi
    fi
}

dwm_spotify
