#!/usr/bin/env zsh

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
PROMPT='${vcs_info_msg_1_}$ '
zstyle ':vcs_info:git:*' formats       ' GIT, BABY! [%b]'
zstyle ':vcs_info:git:*' actionformats ' GIT ACTION! [%b|%a]'
# zstyle ':vcs_info:git:*' formats '%b'

get_prompt() {
	# 256-colors check (will be used later): tput colors
	echo -n "%F{6}%n%f" # User
	echo -n "%F{8}@%f" # at
	echo -n "%F{12}%m%f" # Host
	echo -n "%F{8}:%f" # in 
	echo -n "%{$reset_color%}%~" # Dir
	echo -n "\n"
	echo -n $PROMPT 
}

PROMPT=$(get_prompt)
