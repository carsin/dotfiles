fortune ~/.config/fortune/fortunes


# Append to path
path+=($HOME/bin:/usr/local/bin:$PATH)
# path+=($HOME/Library/Python/3.8/bin)
path+=("/usr/local/sbin:$PATH")
# path+=($HOME/.emacs.d/bin)
# path+=(/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH)

# Left side
PROMPT="%B%{$fg[red]%}%n%b%{$reset_color%}@%{$fg[magenta]%}%m %{$fg[blue]%}[%{$fg[blue]%}%B %~ %b%{$fg[blue]%}]  %f$ "
# Right side
# PROMPT='$(git_prompt_info) %F{blue}[ %F{red}%D{%L:%M:%S} %D{%p} %F{blue}]%f'
RPROMPT='%F{blue}[ %F{red}%D{%L:%M:%S} %D{%p} %F{blue}]%f'

# ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
# ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
# ZSH_THEME_GIT_PROMPT_CLEAN=""

export GPG_TTY=$(tty)

alias ..="cd .."
alias ~="cd ~"
alias vim="nvim"
alias ls="exa -aF --color=always --sort=type --group-directories-first"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias bc="bc -ql"
alias mkdir="mkdir -pv"

alias grep="grep --color=auto"
alias diff="diff --color=auto"

alias g="git"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

alias cr="cargo run"
alias crr="cargo run --release"

alias killglobal="launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias startglobal="launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"

alias python="python3"
alias calpoly="ssh ckfreedm@unix3.csc.calpoly.edu"
alias open="open ."

export PATH
