# run fortune at startup as welcome message
fortune ~/.config/fortune/fortunes

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Import colorscheme from wal asynchronously
(cat ~/.cache/wal/sequences &)

# Add wal support for TTYs
source ~/.cache/wal/colors-tty.sh

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=10

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Use lf to switch directories and bind it to ctrl-f
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Append bin dirs to path
path+=($HOME/bin:/usr/local/bin:$PATH)
# path+=($HOME/Library/Python/3.8/bin)
path+=("/usr/local/sbin:$PATH")
# path+=(/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH)

# Left side
# PROMPT="%B%{$fg[red]%}%n%b%{$reset_color%}@%{$fg[magenta]%}%m %{$fg[blue]%}[%{$fg[blue]%}%B %~ %b%{$fg[blue]%}]  %f$ "
# Right side
# PROMPT='$(git_prompt_info) %F{blue}[ %F{red}%D{%L:%M:%S} %D{%p} %F{blue}]%f'
# RPROMPT='%F{blue}[ %F{red}%D{%L:%M:%S} %D{%p} %F{blue}]%f'

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

alias ..="cd .."
alias ~="cd ~"
alias vim="nvim"
alias ls="exa -aF --color=always --sort=type --group-directories-first"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias bc="bc -ql"
alias mkdir="mkdir -pv"

alias g="git"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

alias cr="cargo run"
alias crr="cargo run --release"

alias killglobal="launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias startglobal="launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"

alias python="python3"
alias calpoly="ssh ckfreedm@unix3.csc.calpoly.edu"
alias open="open ."

alias sp="spt"

# Load p10k config
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export GPG_TTY=$TTY
export PATH
