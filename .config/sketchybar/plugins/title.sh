#!/usr/bin/env bash

APP_NAME=$(yabai -m query --windows --window | jq '.app' | sed -E 's/^"(.*)"$/\1/' | sed 's@\\@@g')
WINDOW_TITLE=$(yabai -m query --windows --window | jq '.title' | sed -E 's/^"(.*)"$/\1/' | sed 's@\\@@g')
if [[ $WINDOW_TITLE = "" ]]; then
  sketchybar -m set title label " > $APP_NAME"
else
  if [[ ${#WINDOW_TITLE} -gt 70 ]]; then
    WINDOW_TITLE=$(echo "$WINDOW_TITLE" | cut -c 1-50)
    sketchybar -m set title label " > $WINDOW_TITLE"…
  else
    sketchybar -m set title label " > $WINDOW_TITLE"
  fi
fi
