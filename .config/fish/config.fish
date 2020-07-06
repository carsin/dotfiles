# Start tmux or reopen tmux
if not set -q TMUX
    tmux attach -t base || tmux new -s base
end

alias vi="vim"
alias v="vim"
alias ls="ls -A --color"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias tmux="tmux -2"
alias cr="cargo run"
alias gst="git status"
alias gp="git push"
alias cst="config status"
alias cp="config push"

function fish_greeting
    fortune | cowsay
end

export PATH="$HOME/.cargo/bin:$PATH"
