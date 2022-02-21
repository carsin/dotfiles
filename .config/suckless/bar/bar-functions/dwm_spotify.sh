#!/bin/sh

# A dwm_bar function that shows the current artist, track, duration, and status from Spotify using playerctl
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: spotify/spotifyd, playerctl

# NOTE: The official spotify client does not provide the track position or shuffle status through playerctl. This does work through spotifyd however.

dwm_spotify () {
    if ps -C spotify > /dev/null; then
        PLAYER="spotify"
    elif ps -C spotifyd > /dev/null; then
        PLAYER="spotifyd"
    elif ps -C ncspot > /dev/null; then
        PLAYER="ncspot"
    fi

    if [ "$PLAYER" = "spotify" ] || [ "$PLAYER" = "spotifyd" ] || [ "$PLAYER" = "ncspot" ]; then
        ARTIST=$(playerctl --player="$PLAYER" metadata artist)
        TRACK=$(playerctl --player="$PLAYER" metadata title)
        POSITION=$(playerctl --player="$PLAYER" position | sed 's/..\{6\}$//')
        DURATION=$(playerctl --player="$PLAYER"metadata mpris:length | sed 's/.\{6\}$//')
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
            printf "%s%s - %s" "$SEP1" "$ARTIST" "$TRACK"
            printf " %0d:%02d/" $((POSITION%3600/60)) $((POSITION%60))
            printf "%0d:%02d" $((DURATION%3600/60)) $((DURATION%60))
            printf "%s" "$SEP2"
        fi
    fi
}

dwm_spotify
