#!/bin/bash

actual=$(cat /sys/class/backlight/intel_backlight/brightness)

if [ "$actual" == 50 ];then
	exit
else
	if [ "$actual" == 100 ];then		
		echo "$(($actual - 50))" >> /sys/class/backlight/intel_backlight/brightness
	else	
		echo "$(($actual - 100))" >> /sys/class/backlight/intel_backlight/brightness
	fi
fi


