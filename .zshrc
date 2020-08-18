fortune ~/.config/fortune/fortunes

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/carson/.oh-my-zsh"

# Use better directory for customizations
ZSH_CUSTOM=$HOME/.config/ohmyzsh

# Themes I like: dieter eastwood geoffgarside maran
ZSH_THEME="carson"

# Load oh my zsh
source $ZSH/oh-my-zsh.sh

plugins=(git safe-paste osx zsh-syntax-highlighting zsh-autosuggestions)

alias vim="nvim"
# alias ls="gls -AhF --color --group-directories-first"
alias ls="exa -aF --color=always --sort=type --group-directories-first"
alias dots="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
