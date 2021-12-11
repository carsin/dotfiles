#!/usr/bin/env bash
UPDOWN=$(ifstat -i "en0,en6" -b 0.1 2 | tail -n1)
UP_WIFI=$(echo $UPDOWN | awk "{ print \$2 }" | cut -f1 -d ".")
DOWN_WIFI=$(echo $UPDOWN | awk "{ print \$1 }" | cut -f1 -d ".")
UP_ETH=$(echo $UPDOWN | awk "{ print \$4 }" | cut -f1 -d ".")
DOWN_ETH=$(echo $UPDOWN | awk "{ print \$3 }" | cut -f1 -d ".")
UP=
DOWN=
if [[ $UP_ETH != "n/a" ]]; then
  UP=$(($UP_WIFI + $UP_ETH))
  DOWN=$(($DOWN_WIFI + $DOWN_ETH))
else
  UP=$UP_WIFI
  DOWN=$DOWN_WIFI
fi

UP_FORMAT=""
if [[ "$UP" -gt 999 ]]; then
  UP_FORMAT=$(echo $UP | awk '{ printf "%.0f Mbps", $1 / 1000}')
else
  UP_FORMAT=$(echo $UP | awk '{ printf "%.0f kbps", $1}')
fi

DOWN_FORMAT=""
if [[ "$DOWN" -gt 999 ]]; then
  DOWN_FORMAT=$(echo $DOWN | awk '{ printf "%.0f Mbps", $1 / 1000}')
else
  DOWN_FORMAT=$(echo $DOWN | awk '{ printf "%.0f kbps", $1}')
fi

sketchybar -m --set network_up label="$UP_FORMAT" label.highlight=$(if [[ "$UP" -gt 0 ]]; then echo "on"; else echo "off"; fi)
sketchybar -m --set network_down label="$DOWN_FORMAT" label.highlight=$(if [[ "$DOWN" -gt 0 ]]; then echo "on"; else echo "off"; fi)
