#!/bin/sh

cd /home/carson/files/music/spotify/bp/scrape2/ || exit

if [[ $1 = "" ]]; then
    read -p "url: " url 
else
    url=$1
fi

youtube-dl --no-continue --download-archive downloaded.txt --audio-format best --extract-audio -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s.%(ext)s' --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata "$url"
