#!/bin/bash

CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

COLOR="%{F#55}"
RED="%{F#FF0000}"
WHITE="%{F#A6A6A6}"

ICON_0=""
ICON_1=""
ICON_2=""
ICON_3=""
ICON_4=""

ICON_WARNING=""
ICON_CHARGE=""


if [ "$STATUS" == "Discharging" ]; then
				if [ "$CAPACITY" -eq 100 ] || [ "$CAPACITY" -lt 100 ] && [ "$CAPACITY" -gt 80 ]; then
								echo "$COLOR$ICON_4  $WHITE$CAPACITY"
				elif [ "$CAPACITY" -eq 80 ] || [ "$CAPACITY" -lt 80 ] && [ "$CAPACITY" -gt 60 ]; then
								echo "$COLOR$ICON_3  $WHITE$CAPACITY"
				elif [ "$CAPACITY" -eq 60 ] || [ "$CAPACITY" -lt 60 ] && [ "$CAPACITY" -gt 40 ]; then
								echo "$COLOR$ICON_2  $WHITE$CAPACITY"
				elif [ "$CAPACITY" -eq 40 ] || [ "$CAPACITY" -lt 40 ] && [ "$CAPACITY" -gt 20 ]; then
								echo "$COLOR$ICON_1  $WHITE$CAPACITY"
				elif [ "$CAPACITY" -eq 20 ] || [ "$CAPACITY" -lt 20 ] && [ "$CAPACITY" -gt 10 ]; then
								echo "$COLOR$ICON_0  $WHITE$CAPACITY"
				elif [ "$CAPACITY" -eq 10 ] || [ "$CAPACITY" -lt 10 ] && [ "$CAPACITY" -gt 0 ]; then
								echo "$RED$ICON_WARNING  $WHITE$CAPACITY"
				fi
elif [ "$STATUS" == "Full" ]; then
				echo "$COLOR$ICON_4  $WHITE$STATUS"
elif [ "$STATUS" == "Charging" ]; then
								echo "$COLOR$ICON_CHARGE  $WHITE$CAPACITY"
fi
