# ensure XDG defaults are correct
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_RUNTIME_DIR=/run/user/$UID

# etc
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export CARGO_HOME=~/.cache/cargo
