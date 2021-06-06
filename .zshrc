fortune ~/.config/fortune/fortunes
# Set up auto GPG signing
if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info > /dev/null 2>&1
    export GPG_AGENT_INFO > /dev/null 2>&1
else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info > /dev/null 2>&1)
fi

# let pyenv manage python versions
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# if detected, set emacs shell variables so things like doom can find it
# if [ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]; then
#   export EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"
#   alias emacs="$EMACS -nw"
# fi

# if [ -f "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient" ]; then
#   alias emacsclient="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
# fi

# Append to path
path+=($HOME/bin:/usr/local/bin:$PATH)
path+=($HOME/.emacs.d/bin:$PATH)
path+=($HOME/Library/Python/3.8/bin)
path+=("/usr/local/sbin:$PATH")
path+=($HOME/.emacs.d/bin)
# path+=(/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH)
# Path to your oh-my-zsh installation.
export ZSH="/Users/carson/.oh-my-zsh"

export GPG_TTY=$(tty)

# Use better directory for customizations
ZSH_CUSTOM=$HOME/.config/ohmyzsh

# Themes I like: dieter eastwood geoffgarside maran
ZSH_THEME="carson"

plugins=(git safe-paste osx zsh-syntax-highlighting z you-should-use $plugins)

# Load oh my zsh
source $ZSH/oh-my-zsh.sh

alias ..="cd .."
alias vim="nvim"
alias ls="exa -aF --color=always --sort=type --group-directories-first"
alias dots="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

alias cr="cargo run"
alias crr="cargo run --release"

alias killglobal="launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias startglobal="launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"

alias python="python3"
alias calpoly="ssh ckfreedm@unix3.csc.calpoly.edu"
alias pip="/usr/local/bin/pip3"
alias open="open ."
alias npm="pnpm"

export PATH

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

