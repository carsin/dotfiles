# Left side
PROMPT="%B%{$fg[red]%}%n%b%{$reset_color%}@%{$fg[magenta]%}%m %{$fg[blue]%}[ %{$fg[blue]%}%B %~ %b%{$fg[blue]%} ]  %f$ "
# Right side
RPROMPT='$(git_prompt_info) %F{blue}[ %F{red}%D{%L:%M:%S} %D{%p} %F{blue}]%f'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
