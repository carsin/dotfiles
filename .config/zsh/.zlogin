# Prompt for setup choice
# printf "Choose a configuration to load: \n1: Desktop \n2: Laptop\n$ "
# old_stty_cfg=$(stty -g)
# stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Careful playing with stty
# if echo "$answer" | grep -iq "^1" ;then
#     # Desktop specific configuration
#     export ACTIVE_SETUP_CONFIG="desktop"
# else
#     # Laptop specific configuration
#     export ACTIVE_SETUP_CONFIG="laptop"
# fi

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  startx 
fi
