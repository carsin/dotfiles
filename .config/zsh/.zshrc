# https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
# ----------------------------------------------------
# Import colorscheme from wal asynchronously
(cat ~/.cache/wal/sequences &)

# Useful options & defaults
setopt autocd extendedglob nomatch menucomplete interactive_comments

# import functions
source "$ZDOTDIR/functions"

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=$XDG_CACHE_HOME/zsh/.histfile

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

# Don't show inverted % when zsh inserts a newline
unsetopt PROMPT_CR
unsetopt PROMPT_SP 
PROMPT_EOL_MARK=''

# enable vi mode
bindkey -v
export KEYTIMEOUT=10

# let st's terminfo handle key sequences
if [[ $TERM =~ 'st-256color' || $TERM =~ 'xterm-256color' ]]; then
    function zle-line-init () { echoti smkx }
    function zle-line-finish () { echoti rmkx }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Syntax highlighting
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Plugins (provided by zsh-functions)
# zsh_add_plugin "zsh-users/zsh-autosuggestions"
# zsh_add_plugin "hlissner/zsh-autopair"
eval "$(zoxide init zsh)" # zoxide

# Accept autosuggestion
# bindkey '^ ' autosuggest-accept
# bindkey '^l' autosuggest-accept
# bindkey '^[[Z' autosuggest-accept
# bindkey '<Tab>' autosuggest-accept

# jk/kj as escape
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Go up and down in history with ctrl+j & ctrl+k
bindkey '^K' history-search-backward
bindkey '^J' history-search-forward

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# import aliases
source "$ZDOTDIR/aliases"

# load prompt theme
source ~/.config/zsh/themes/carson.zsh-theme # load prompt

# set kitty colors

# export GPG_TTY=$TTY
# export PATH=$PATH:$HOME/.local/bin

# append stuff to path
path+=('/home/carson/.local/bin')
path+=('/home/carson/bin')

export PATH
# run fortune at startup as welcome message
fortune ~/.config/fortune/fortunes
