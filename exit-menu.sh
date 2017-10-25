#!/bin/bash

MENU=$( echo -e "\nLock\nLog Out\nSuspend\nReboot\nPowerOff" | rofi -dmenu -p "System Menu" -lines 6 -location 1 -yoffset 27 -font "DejaVu Sans Ms 9" -width 15 -bw 2 -hide-scrollbar -separator-style solid -line-margin 5) 

if [ "$MENU" == "Lock" ]; then
				physlock
elif [ "$MENU" == "Log Out" ]; then
				i3-msg exit
elif [ "$MENU" == "Suspend" ]; then
				systemctl suspend
elif [ "$MENU" == "Reboot" ]; then
				reboot
elif [ "$MENU" == "PowerOff" ]; then
				systemctl poweroff
fi
