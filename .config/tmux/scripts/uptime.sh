#!/bin/sh

uptime -p >/dev/null 2>&1

# UP=$(uptime | sed -E 's/^[^,]*up *//; s/mins/minutes/; s/hrs?/hours/;
# s/([[:digit:]]+):0?([[:digit:]]+)/\1h, \2m/;
# s/^1hours/1 hour/; s/ 1 hours/ 1 hour/;
# s/min,/minutes,/; s/ 0 minutes,/ less than a minute,/; s/ 1 minutes/ 1 minute/;
# s/  / /; s/, *[[:digit:]]* users?.*//')

UP=$(uptime | sed -E 's/^[^,]*up *//; s/, *[[:digit:]]* user.*//; s/min/min/; s/([[:digit:]]+):0?([[:digit:]]+)/\1h, \2m/' )


echo "up $UP"
