#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3


dwm_resources () {
	# get all the infos first to avoid high resources usage
	free_output=$(free -h | grep Mem)
	# Used and total memory
	MEMUSED=$(echo $free_output | awk '{print $3}' | rev | cut -c 2- | rev)
	MEMTOT=$(echo $free_output | awk '{print $2}')
	# CPU usage
	CPU=$(top -bn1 | grep Cpu | awk '{print $2}')%

	printf "%s" "$SEP1"
    # ﬙
	if [ "$IDENTIFIER" = "unicode" ]; then
		printf " %s ﬘ %s" "$CPU" "$MEMUSED" 
	fi
	printf "%s\n" "$SEP2"
}

dwm_resources
