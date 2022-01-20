timeout 2 wal -a 85 --backend haishoku -i ~/files/photos/wallpapers/ultrawide & 
# sleep 1 && killall -USR1 /usr/local/bin/st &
wait
pywalfox update & # may be causing instability
zathura-pywal -a 0.85
pywal-discord
