#!/bin/bash

actual=$(cat /sys/class/backlight/intel_backlight/brightness)

if [ "$actual" == 937 ];then
	exit	
else
	echo "$(($actual + 100))" >> /sys/class/backlight/intel_backlight/brightness
fi


