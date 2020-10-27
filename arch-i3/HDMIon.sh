#!/bin/bash

if [ -z "$2"]; then
	if [ -z "$1"]; then
		xrandr --output HDMI2 --mode 1360x768 --pos 1600x0 --rotate normal 
		DISPLAY=:0.0 feh --bg-scale ~/Pictures/laDef.jpg
	else
		xrandr --output HDMI2 --mode $1 --pos 1600x0 --rotate normal
		DISPLAY=:0.0 feh --bg-scale ~/Pictures/laDef.jpg
	fi
else
	if [ "$2" == "right" ]; then
		if [ -z "$1"]; then
			xrandr --output HDMI2 --mode 1360x768 --pos 1600x0 --rotate normal 
			DISPLAY=:0.0 feh --bg-scale ~/Pictures/laDef.jpg
		else
			xrandr --output HDMI2 --mode $1 --pos 1600x0 --rotate normal
			DISPLAY=:0.0 feh --bg-scale ~/Pictures/laDef.jpg
		fi
	elif [ "$2" == "left" ]; then
		if [ -z "$1"]; then
			xrandr --output HDMI2 --mode 1360x768 --pos -1600x0 --rotate normal 
			DISPLAY=:0.0 feh --bg-scale ~/Pictures/laDef.jpg
		else
			xrandr --output HDMI2 --mode $1 --pos -1600x0 --rotate normal
			DISPLAY=:0.0 feh --bg-scale ~/Pictures/laDef.jpg
		fi
	fi
fi
