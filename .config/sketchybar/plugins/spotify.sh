#!/usr/bin/env bash

RUNNING=$(osascript -e 'if application "Spotify" is running then return 0')
if [ "$RUNNING" == "" ]; then
  RUNNING=1
fi
PLAYING=1
TRACK=""
ALBUM=""
ARTIST=""


next ()
{
  if [ $RUNNING -eq 0 ]; then
    osascript -e 'tell application "Spotify" to play next track'
  fi
}

back ()
{
  if [ $RUNNING -eq 0 ]; then
    osascript -e 'tell application "Spotify" to play previous track'
  fi
}

play_pause ()
{
  if [ $RUNNING -eq 0 ]; then
    osascript -e 'tell application "Spotify" to playpause'
  fi
}

name ()
{
  if [ "$(osascript -e 'if application "Spotify" is running then tell application "Spotify" to get player state')" == "playing" ]; then
    PLAYING=0
    TRACK=$(osascript -e 'tell application "Spotify" to get name of current track')
    ARTIST=$(osascript -e 'tell application "Spotify" to get artist of current track')
    ALBUM=$(osascript -e 'tell application "Spotify" to get album of current track')
  fi

  if [ $RUNNING -eq 0 ] && [ $PLAYING -eq 0 ]; then
    if [ "$ARTIST" == "" ]; then
      sketchybar -m --set spotify_name label="$ALBUM / $TRACK" drawing=on \
                          --set spotify_play_pause label= drawing=on \
                          --set spotify_next drawing=on \
                          --set spotify_back drawing=on
    else
      sketchybar -m --set spotify_name label="$ARTIST - $TRACK" drawing=on \
                          --set spotify_play_pause icon= drawing=on \
                          --set spotify_next drawing=on \
                          --set spotify_back drawing=on
    fi
  else
    sketchybar -m --set spotify_name drawing=off \
                        --set spotify_play_pause icon= drawing=on \
                        --set spotify_next drawing=on \
                        --set spotify_back drawing=on
  fi
}

case "$NAME" in
  "spotify_next") next
  ;;
  "spotify_back") back
  ;;
  "spotify_play_pause") play_pause
  ;;
  "spotify_name") name
  ;;
  *) echo "Invalid mode for Spotify script"
  ;;
esac
