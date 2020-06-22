alias vi="vim"
alias v="vim"
alias ls="ls -A --color"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias tmux="tmux -2"
alias cr="cargo run"

function fish_greeting
    fortune | cowsay
end

export PATH="$HOME/.cargo/bin:$PATH"
