#!/bin/bash

dwm_weather() {
    DATA=$(curl -s wttr.in/San+Luis+Obispo?format=1)
    export __DWM_BAR_WEATHER__="$DATA$SEP2"
}

dwm_weather
