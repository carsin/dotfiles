VOLUME=$(osascript -e 'output volume of (get volume settings)')

sketchybar -m --set volume label=$VOLUME%

if [[ $VOLUME -eq 0 ]]; then
    sketchybar -m --set $NAME icon=ﱝ
elif [[ $VOLUME -ge 11 ]] && [[ $VOLUME -le 49 ]]; then
    sketchybar -m --set $NAME icon=
elif [[ $VOLUME -ge 50 ]] && [[ $VOLUME -le 100 ]]; then
    sketchybar -m --set $NAME icon=
fi
