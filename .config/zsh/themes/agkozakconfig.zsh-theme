AGKOZAK_CMD_EXEC_TIME=3
AGKOZAK_CMD_EXEC_TIME_CHARS=( '%F{blue}[took ' "]" )
AGKOZAK_PROMPT_DIRTRIM=5
AGKOZAK_BLANK_LINES=0
AGKOZAK_MULTILINE=0
AGKOZAK_USER_HOST_DISPLAY=1
AGKOZAK_CUSTOM_RPROMPT='%(3V.%F{yellow}%3v%f.) %F{magenta}%*'

AGKOZAK_COLORS_PATH=cyan
AGKOZAK_COLORS_USER_HOST=default
if [[ $IS_FTERM = 1 ]]; then
    AGKOZAK_COLORS_HOST_HOST=red
    AGKOZAK_COLORS_AT_SYMBOL=green
    AGKOZAK_PROMPT_CHAR=( '%F{magenta}$' '%F{red}%%' '%F{blue}>' )
else
    AGKOZAK_COLORS_HOST_HOST=yellow
    AGKOZAK_COLORS_AT_SYMBOL=green
    AGKOZAK_PROMPT_CHAR=( '%F{red}$' '%F{red}%%' '%F{blue}>' )
fi

# modified promtpstring @ line 955
# AGKOZAK[PROMPT]+='%(!.%S%B.%F{${AGKOZAK_COLORS_USER_HOST:-green}})%n%F{$AGKOZAK_COLORS_AT_SYMBOL}%B@%b%F{$AGKOZAK_COLORS_HOST_HOST}%1v%(!.%s.%f%b) '
# hostname for non-ssh @ line 1033
# if _agkozak_is_ssh || (( EUID == 0 )); then
#   psvar[1]="${(%):-%m}"
# else
#   psvar[1]="${(%):-%m}"
# fi
