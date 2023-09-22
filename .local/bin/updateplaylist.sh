#!/bin/sh
# shellcheck disable=2016

cd ~/files/music/spotify/bp/scrape/ || exit

# CSX
echo 'Downloading CSX'

yt-dlp --download-archive downloaded.txt --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PL4PofEZT9GHow6tHzD8Gp6NpSXbPHO97B --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
yt-dlp --download-archive downloaded.txt --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLhelXIJEzFPDWIs3NUK_E6MibN4vYe0hZ --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200


echo 'Playlist CSX finished downloading'

# Fear 1
echo 'Downloading Fear 1'
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PL_fNrCkNoX3e4VOWWi0V_WsnC9dORiJLL --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200

echo 'Playlist Fear 1 finished downloading'

# Fear 2
echo 'Downloading Fear 2'
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PL_fNrCkNoX3dY1X6gsSmfgRK2yA8Pr2Al --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200

echo 'Playlist Fear 2 finished downloading'

# DNA
echo 'Downloading DNA'
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLrA41AIkBqnK0K3Nueo0JTH2P-pkEAZEz --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200

echo 'Playlist DNA finished downloading'

# Kloudz 333
echo 'Downloading Kloudz 33'
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLBTAY2snT7uHPM87CB0DLXbrjdY9CjbDf --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist Kloudz 333 finished downloading'

# C$X Test
echo 'Downloading MEX: C$X Test'
# yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PL_fNrCkNoX3dXQBHEs429z_F1iTHf2Oe4 --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist MEX: C$X Test finished downloading'

# Mex test
echo 'Downloading MEX Test'
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PL4PofEZT9GHrkU5YzY_EsDA_0A-qCxeYE --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist MEX Test finished downloading'

# Luna to the moon
echo 'Downloading Luna: to the moon'
# --restrict-filenames fixes undownloadable ascii chars
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - (uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLZL0uQ9nkwWxXdJMaoMntO_CYKjVJrEAE --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200 --restrict-filenames
echo 'Playlist Luna finished downloading'

# Permaban
echo 'Downloading Permaban'
# yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLZW5bl8Qpvk0yx0w9cNoRUtdm8zKuZIqy --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata
echo 'Playlist Permaban finished downloading'

# Neverland
echo 'Downloading Neverland'
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLdIDJawYJSxWzXIJV1WmOvV20ZU5ye2LJ --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist Neverland finished downloading'

# sextek
# echo 'Downloading sextek'
# yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLTwLDJl0Tns0W7HUtdBxFdOWnOXtwkw5l --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata
# echo 'Playlist sextek finished downloading'

# 3am
echo 'Downloading 3am'
# yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PL_fNrCkNoX3eVg_mwZ3AA216qCJ_mU2w3 --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist 3am finished downloading'

# Sky
echo 'Downloading sky'
# yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PL_fNrCkNoX3dY1X6gsSmfgRK2yA8Pr2Al --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist sky finished downloading'

# KING
echo 'Downloading KING'
# yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - %(uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PL_fNrCkNoX3dXQBHEs429z_F1iTHf2Oe4 --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist KING finished downloading'

# firgi Tired
echo "Downloading firgi's tired"
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - (uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLdIDJawYJSxVyTuflOiKIxVfczb6h5SFA --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist tired finished downloading'

# eto unlisted
echo "Downloading eto unlisted"
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - (uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLmF-mtoxUrRbf7Rqcjq6NmoDi-lghweWE --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist eto unlisted finished downloading'

# eto wonderland
echo "Downloading eto wonderland"
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - (uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLmF-mtoxUrRYGIqmACu29FTgTyObdVsFE --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist eto wonderland finished downloading'

# eto full
echo "Downloading eto full"
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - (uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLmF-mtoxUrRakTFbcOZQY-izbneg3Z13A --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist eto full finished downloading'

# shmurda secret
echo "Downloading shmurda secret"
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - (uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLluWecZRzY_TsaiHsb5Yif1fbGCjvNN91 --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist shmurda secret finished downloading'

# tomas secret
echo "Downloading tomas secret"
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - (uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLjdRAQ9W4wSY8a8zIjU_-xWJmiCcoNzaq --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200
echo 'Playlist tomas secret finished downloading'

# nebula
echo "Downloading nebula"
yt-dlp --download-archive downloaded.txt -f m4a --extract-audio --audio-format best -S'+acodec:140,m4a,mp3' -o '%(title)s - (uploader)s [%(id)s].%(ext)s' https://www.youtube.com/playlist?list=PLdqoDgM67Sc3LZsO487fhx-NsUFM071po --ignore-errors --add-metadata --embed-thumbnail --compat-options embed-metadata --trim-filenames 200

# echo 'Playlist tomas secret finished downloading'

echo 'EDM update complete!'
