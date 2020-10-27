#!/bin/bash

BATTERY_PATH="/sys/class/power_supply/BAT0/"

NOTIFY=false
SUSPEND=false

function notification {
				if [ "$1" -lt 10 ]; then
								notify-send --icon=battery "Battery is low - $1%"
								NOTIFY=true
								sleep 2
				fi
}				

function suspend {
				if [ "$1" -lt 5 ] && [ "$SUSPEND" == "false" ]; then
								notify-send --icon=battery "System will suspend in few seconds"
								sleep 30
								BATTERY_STATUS=$(cat $BATTERY_PATH/status)
								if [ "$BATTERY_STATUS" == "Discharging" ]; then
												systemctl suspend
												SUSPEND=true
 								fi	
				fi
}

while true
do
				BATTERY_STATUS=$(cat $BATTERY_PATH/status)
				CURRENT_BATTERY=$(cat $BATTERY_PATH/capacity)
				
				if [ "$BATTERY_STATUS" == "Discharging" ]; then
								case $NOTIFY in
												(false) notification $CURRENT_BATTERY;;
												(true) suspend $CURRENT_BATTERY;;
								esac

				elif [ "$BATTERY_STATUS" == "Charging" ]; then
								NOTIFY=false
								SUSPEND=false
				elif [ "$BATTERY_STATUS" == "Full" ]; then
								notify-send --icon=battery "Battery is full"
				fi
				echo $BATTERY_STATUS
				sleep 2

done

