#!/usr/bin/bash
# TODO: mtrack
# https://howchoo.com/linux/the-perfect-almost-touchpad-settings-on-linux-2

# enable move cursor while typing
xinput --set-prop 'bcm5974' 'libinput Disable While Typing Enabled' 0

# scale base cursor speed 
xinput --set-prop 'bcm5974' 'libinput Accel Speed' '0.4'

# enable acceleration
xinput --set-prop 'bcm5974' 'libinput Accel Profile Enabled' 1

# dont scroll so far
xinput --set-prop 'bcm5974' 'libinput Scrolling Pixel Distance' 10

echo 'initalized bcm5974 settings'
