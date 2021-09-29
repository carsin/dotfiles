# run fortune at startup as welcome message
fortune ~/.config/fortune/fortunes

# Import colorscheme from wal asynchronously
(cat ~/.cache/wal/sequences &)

# Enable Powerlevel10k instant prompt.
if [[ $TERM =~ 'xterm-kitty' || $TERM =~ 'alacritty' ]]; then
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
fi

# Useful options & defaults
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments

# import functions
source "$ZDOTDIR/zsh-functions"

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

# Don't show inverted % when zsh inserts a newline
PROMPT_EOL_MARK=''

# vi mode
bindkey -v
export KEYTIMEOUT=10

# jk/kj as escape
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Go up and down in history with ctrl+j & ctrl+k
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Plugins (provided by zsh-functions)
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "agkozak/zsh-z"

# Accept autosuggestion
bindkey '^ ' autosuggest-accept
# bindkey '^l' autosuggest-accept

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

# tab to accept suggestion
# bindkey '<Tab>' autosuggest-accept

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Append bin dirs to path
path+=($HOME/bin:/usr/local/bin:$PATH)
# path+=($HOME/Library/Python/3.8/bin)
path+=("/usr/local/sbin:$PATH")
path+=("/Users/carson/Library/Python/3.9/bin")
path+=("/usr/local/opt/llvm/bin/")
path+=("/usr/local/opt/binutils/bin:$PATH")
path+=("/Users/carson/.cargo/bin")
path+=("")

# import aliases
source "$ZDOTDIR/zsh-aliases"

if [[ $TERM =~ 'xterm-kitty' || $TERM =~ 'alacritty' ||$TERM =~ 'screen-256color' ]];
then
    # load p10k
    source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
    [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
else
    # basic prompt
    source ~/.config/zsh/themes/vimterm.zsh-theme
fi

if [[ $TERM =~ 'xterm-kitty' ]]; then
    kitty @ --to unix:/tmp/mykitty --to unix:/tmp/mykitty set-colors ~/.cache/wal/colors-kitty.conf
fi

source ~/.cache/wal/colors-tty.sh

export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export GPG_TTY=$TTY
export TASKRC=~/.config/taskwarrior-tui/.taskrc
# export JAVA_HOME="/Users/carson/Library/Java/JavaVirtualMachines/openjdk-17/Contents/Home"
export JAVA_HOME="/usr/local/Cellar/openjdk@11/11.0.12/libexec/openjdk.jdk/Contents/Home"
export JDTLS_HOME="~/.local/bin/eclipse.jdt.ls/"
export CPPFLAGS="-I/usr/local/opt/openjdk@11/include"
export TASKDATA=~/.config/taskwarrior-tui/.task
export VIT_DIR=~/.config/vit
export SPICETIFY_CONFIG=~/.config/spicetify
export LC_ALL=en_US.UTF-8
# export TERM=xterm-256color
export PATH=$PATH:$HOME/.local/bin
