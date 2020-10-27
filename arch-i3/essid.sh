#!/bin/bash

BLUE="%{F#55}"
WHITE="%{F#A6A6A6}"

ESSID_LOGO=""
ESSID=$(iwgetid -r)

LAN_LOGO=""
LAN=$(ip add show wlp59s0 | grep -o '192.*.net' | cut -d ' ' -f 1)

PUBLIC_LOGO=""
PUBLIC=$(wget -qO- http://ipecho.net/plain ; echo)

#MAC_ROOT_LOGO=""
#MAC_ROUT=$(arp -n | grep wlp59s0 | cut -d ' ' -f 18 | tr '[:lower:]' '[:upper:]' )

if [ -z "$ESSID" ]; then
				echo "$BLUE$WHITE Networking Is Down$BLUE "
else
				if [ -z "$LAN" ]; then
								echo "$BLUE$ESSID_LOGO $WHITE$ESSID   $BLUE$PUBLIC_LOGO $WHITE$PUBLIC"
				else
								echo "$BLUE$ESSID_LOGO $WHITE$ESSID   $BLUE$LAN_LOGO $WHITE$LAN   $BLUE$PUBLIC_LOGO $WHITE$PUBLIC"
				fi
fi
