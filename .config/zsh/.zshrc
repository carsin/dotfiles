# https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
# ----------------------------------------------------
# Import colorscheme from wal asynchronously
(cat ~/.cache/wal/sequences &)

# Useful options & defaults
setopt autocd extendedglob nomatch menucomplete interactive_comments
stty stop undef # Disable ctrl-s to freeze terminal.

# let st's terminfo handle key sequences
if [[ $TERM =~ 'st-256color' ]]; then
    function zle-line-init () { echoti smkx }
    function zle-line-finish () { echoti rmkx }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# import functions
source "$ZDOTDIR/functions"

# History in cache directory:
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=$XDG_CACHE_HOME/zsh/.histfile

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots) # Include hidden files.

# Don't show inverted % when zsh inserts a newline
unsetopt PROMPT_CR
unsetopt PROMPT_SP 
PROMPT_EOL_MARK=''

# Syntax highlighting
# Plugins (provided by zsh-functions)
# zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "agkozak/agkozak-zsh-prompt"
source ~/.config/zsh/themes/agkozakconfig.zsh-theme
eval "$(zoxide init zsh)" # zoxide

# BINDINGS
# Accept autosuggestion
bindkey '^ ' autosuggest-accept
bindkey '^l' autosuggest-accept
bindkey '^[[Z' autosuggest-accept
bindkey '<Tab>' autosuggest-accept

# jk/kj as escape
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

# enable vi mode
bindkey -v
export KEYTIMEOUT=10

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# return to accept match
bindkey -M menuselect '^M' .accept-line
# backward in menu
bindkey '^[[Z' reverse-menu-complete

# Go up and down in history with ctrl+p & ctrl+n
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# fzf
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
# nvim
bindkey -s '^e' 'nvim\n'


# word manip
# ctrl+backspace: delete word before
bindkey '^H' backward-kill-word
# ctrl+delete: delete word after
bindkey "\e[3;5~" kill-word
# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

# import aliases
source "$ZDOTDIR/aliases"
# source ~/.config/zsh/themes/carson.zsh-theme # load prompt

# append stuff to path
path+=('/home/carson/.local/bin')
path+=('/home/carson/bin')

export PATH
# run fortune at startup as welcome message

fortune ~/.config/fortune/fortunes
