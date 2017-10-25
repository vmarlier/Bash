#!/bin/bash

COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

KERNEL_LOGO=""
KERNEL=$(uname -r)
PACMAN_LOGO="PAC"
AUR_LOGO="AUR"

CONNECT=$(iwgetid -r)
if [ -z "$CONNECT" ]; then
		PACMAN="X"
		AUR="X"
else		
		PACMAN=$(checkupdates | wc -l)
		AUR=$(cower -u | wc -l)
fi
PACKAGE_LOGO=""
PACKAGE=$(pacman -Qe | wc -l)

TRASH_LOGO=""
TRASH=$(pacman -Qdtq | wc -l)

echo "$COLOR$PACMAN_LOGO  $WHITE[$PACMAN]   $COLOR$AUR_LOGO  $WHITE[$AUR]   $COLOR$PACKAGE_LOGO  $WHITE[$PACKAGE]   $COLOR$TRASH_LOGO  $WHITE[$TRASH]   $COLOR$KERNEL_LOGO  $WHITE[$KERNEL]"
