# Colors
CA="\e[34m"  # Accent
CO="\e[32m"  # Ok
CW="\e[33m"  # Warning
CE="\e[31m"  # Error
CN="\e[0m"   # None

# Max width used for components in second column
WIDTH=80

# Services to show
declare -A services
services["bluetooth"]="bluetooth"
services["sshd"]="ssh"
services["mbpfan"]="fan"
