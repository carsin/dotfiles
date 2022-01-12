# ensure XDG defaults are correct
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_RUNTIME_DIR=/run/user/$UID
export XDG_DESKTOP_DIR=~/files/desktop
export XDG_DOWNLOAD_DIR=~/files/desktop
export XDG_MUSIC_DIR=~/files/music
export XDG_PICTURES_DIR=~/files/photos

# locale
export TZ='Pacific/Honolulu'
export LANGUAGE='en'
export LANG='en_US.UTF-8'

# hidden 
source ~/.config/zsh/.zprivate
# etc
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export CARGO_HOME=$XDG_CACHE_HOME/cargo
export RUSTUP_HOME=$XDG_CACHE_HOME/rustup
export GLOBAL_FONT="Dina:size=10:antialias=false:hinting=true"
