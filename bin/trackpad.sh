#!/usr/bin/bash

# get ID consistently (it changes when plugging other input in)
trackpadid="$(xinput list --id-only pointer:'bcm5974')"

# enable move cursor while typing
xinput --set-prop $trackpadid 'libinput Disable While Typing Enabled' 0
# scale base cursor speed 
xinput --set-prop $trackpadid 'libinput Accel Speed' '0.55'
# disable acceleration
xinput --set-prop $trackpadid 'libinput Accel Profile Enabled' 0

echo 'initalized bcm5974 settings'
