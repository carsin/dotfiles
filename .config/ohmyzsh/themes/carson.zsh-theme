# Left side
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[cyan]%}[ %{$fg[green]%}%~%{$fg[cyan]%} ] %f$ "
# Right side
RPROMPT='$(git_prompt_info) %F{cyan}[ %F{green}%D{%L:%M:%S} %D{%p} %F{cyan}]%f'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
