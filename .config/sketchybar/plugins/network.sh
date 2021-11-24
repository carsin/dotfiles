#!/usr/bin/env bash
UPDOWN_WIFI=$(ifstat -i "en0" -b 0.1 1 | tail -n1)
export UP=$(echo $UPDOWN_WIFI | awk "{ print \$2 }" | cut -f1 -d ".")
export DOWN=$(echo $UPDOWN_WIFI | awk "{ print \$1 }" | cut -f1 -d ".")
echo $DOWN

UPDOWN_ETH=$(ifstat -i "en6" -b 0.1 1 | tail -n1)
if [[ "$UPDOWN_ETH" != "n/a n/a" ]]; then # ethernet is connected
  UP_ETH=$(echo $UPDOWN_ETH | awk "{ print \$2 }" | cut -f1 -d ".")
  DOWN_ETH=$(echo $UPDOWN_ETH | awk "{ print \$1 }" | cut -f1 -d ".")
  export UP=$(($UP + $UP_ETH))
  export DOWN=$(($DOWN + $DOWN_ETH))
fi


DOWN_FORMAT=""
if [ "$DOWN" -gt "999" ]; then
  DOWN_FORMAT=$(echo $DOWN | awk '{ printf "%.0f Mbps", $1 / 1000}')
else
  DOWN_FORMAT=$(echo $DOWN | awk '{ printf "%.0f kbps", $1}')
fi

UP_FORMAT=""
if [ "$UP" -gt "999" ]; then
  UP_FORMAT=$(echo $UP | awk '{ printf "%.0f Mbps", $1 / 1000}')
else
  UP_FORMAT=$(echo $UP | awk '{ printf "%.0f kbps", $1}')
fi

sketchybar -m --set network_up label="$UP_FORMAT" label.highlight=$(if [ "$UP" -gt "0" ]; then echo "on"; else echo "off"; fi)
sketchybar -m --set network_down label="$DOWN_FORMAT" label.highlight=$(if [ "$DOWN" -gt "0" ]; then echo "on"; else echo "off"; fi)
