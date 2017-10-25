#!/bin/bash

STATE=$(amixer get Master | sed -n 5p | cut -d '[' -f 4 | cut -d ']' -f 1)


if [ "$STATE" == "on" ]; then
				amixer sset Master mute && amixer sset Headphone mute
elif [ "$STATE" == "off" ]; then
				amixer sset Master unmute && amixer sset Speaker unmute && amixer sset Headphone unmute
fi
