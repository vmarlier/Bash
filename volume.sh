#!/bin/bash

COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

STATE=$(amixer get Master | sed -n 5p | cut -d '[' -f 4 | cut -d ']' -f 1)
PERCENT=$(amixer get Master | sed -n 5p | cut -d '[' -f 2 | cut -d '%' -f 1)

ICON_OFF=""
ICON_DOWN=""
ICON_UP=""

if [ "$STATE" == "off" ]; then
				echo "$COLOR$ICON_OFF $WHITE$STATE"
elif [ "$STATE" == "on" ]; then
			if [ "$PERCENT" -lt 50 ]; then
						echo "$COLOR$ICON_DOWN $WHITE$PERCENT"
			elif [ "$PERCENT" -eq 50 ] || [ "$PERCENT" -gt 50 ]; then
						echo "$COLOR$ICON_UP $WHITE$PERCENT"
			fi
fi	

