#!/bin/bash

COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

ICON_DATE=""
DATE=$(date '+%A %d %B')

ICON_HOUR=""
HOUR=$(date +%H:%M:%S)

echo "$WHITE$HOUR, $WHITE$DATE"
