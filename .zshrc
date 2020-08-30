fortune ~/.config/fortune/fortunes

# Append to path
path+=($HOME/bin:/usr/local/bin:$PATH)
path+=($HOME/.emacs.d/bin:$PATH)
# path+="/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH"
# path+=(/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH)

export PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/carson/.oh-my-zsh"

# Use better directory for customizations
ZSH_CUSTOM=$HOME/.config/ohmyzsh

# Themes I like: dieter eastwood geoffgarside maran
ZSH_THEME="carson"

# Load oh my zsh
source $ZSH/oh-my-zsh.sh

plugins=(git safe-paste osx zsh-syntax-highlighting zsh-autosuggestions)

alias ..="cd .."
alias vim="nvim"
alias ls="exa -aF --color=always --sort=type --group-directories-first"
alias dots="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

alias cr="cargo run"
