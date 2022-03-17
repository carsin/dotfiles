#!/bin/bash

printf "%s " "$(uptime | awk -F: '{printf $NF}' | tr -d ',')"
