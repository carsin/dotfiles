# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/carson/.oh-my-zsh"

ZSH_THEME="carson"
# Themes I like: dieter eastwood geoffgarside maran
plugins=(git safe-paste osx)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="ls -a -G"
alias dots="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"