mouseid="$(xinput list --id-only pointer:'Razer Razer Viper Ultimate Dongle')"

# scale cursor speed 

xinput --set-prop $mouseid 'libinput Accel Speed' '0.5'

echo 'set viper speed'
