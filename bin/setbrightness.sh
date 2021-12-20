#!/bin/env bash

MONITOR=acpi_video0
BACKLIGHT_DIR="/sys/class/backlight/$MONITOR"
BRI_FILE="${BACKLIGHT_DIR}/brightness"

$change_bri && sudo echo $1 > "$BRI_FILE"
echo "changing brightness to $1"