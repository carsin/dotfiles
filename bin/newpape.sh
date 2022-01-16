echo "running wal..."
timeout 3 wal -a 85 --backend haishoku -i ~/files/photos/wallpapers/wal & 
echo "done! sending refresh signal to st..."
killall -USR1 /usr/local/bin/st 
echo "complete"
