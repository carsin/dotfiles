alias vi="vim"
alias v="vim"
alias ls="ls -A --color"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias tmux="tmux -2"

function fish_greeting
    fortune | cowsay
end

cd ~
