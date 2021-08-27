# run fortune at startup as welcome message
fortune ~/.config/fortune/fortunes

# Import colorscheme from wal asynchronously
(cat ~/.cache/wal/sequences &)

# Enable Powerlevel10k instant prompt.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Useful options & defaults
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments

# import functions
source "$ZDOTDIR/zsh-functions"

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "agkozak/zsh-z"

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
# path+=(/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH)

# TODO: seperate into zsh aliases file
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
alias mr="make && ./run"

alias killglobal="launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias startglobal="launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"

alias python="python3"
alias calpoly="ssh ckfreedm@unix3.csc.calpoly.edu"
alias open="open ."
alias top="bpytop"

alias sp="spt"
alias o="open"
alias t="taskwarrior-tui"

alias w="wal -i ~/files/photos/wallpapers/wal/ && source ~/.config/spacebar/spacebarcolors && kitty @ set-colors ~/.cache/wal/colors-kitty.conf"
alias w1="wal --backend haishoku -i ~/files/photos/wallpapers/wal/ && source ~/.config/spacebar/spacebarcolors && kitty @ set-colors ~/.cache/wal/colors-kitty.conf"
alias w2="wal --backend colorz -i ~/files/photos/wallpapers/wal/ && source ~/.config/spacebar/spacebarcolors && kitty @ set-colors ~/.cache/wal/colors-kitty.conf"
alias w3="wal --backend colorthief -i ~/files/photos/wallpapers/wal/ && source ~/.config/spacebar/spacebarcolors && kitty @ set-colors ~/.cache/wal/colors-kitty.conf"
alias luamake=/Users/carson/.local/bin/lua-language-server/3rd/luamake/luamake

if [[ $TERM =~ 'xterm-kitty' ]];
then
    # load p10k
    source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
    [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
    kitty @ set-colors ~/.cache/wal/colors-kitty.conf
else
    source ~/.config/zsh/themes/vimterm.zsh-theme
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export GPG_TTY=$TTY
export TASKRC=~/.config/taskwarrior-tui/.taskrc
export TASKDATA=~/.config/taskwarrior-tui/.task
export PATH
