#!/usr/bin/env bash

case "$(yabai -m query --windows --window | jq .floating)" in
    0)
    sketchybar -m --set yabai_float icon="ﱡ"
    ;;
    1)
    sketchybar -m --set yabai_float icon=""
    ;;
esac
