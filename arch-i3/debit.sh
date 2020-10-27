#!/bin/bash

BLUE="%{F#55}"
WHITE="%{F#A6A6A6}"

ESSID=$(iwgetid -r)


DOWNLOAD_LOGO=""
DOWNLOAD=$(sar -n DEV 1 1 | grep wlp59s0 | sed -n 2p | awk '{print $5; print $6}' | sed -n 1p)
UPLOAD_LOGO=""
UPLOAD=$(sar -n DEV 1 1 | grep wlp59s0 | sed -n 2p | awk '{print $5; print $6}' | sed -n 2p)

if [ -z "$ESSID" ]; then
				exit
else
				echo "$BLUE$DOWNLOAD_LOGO $WHITE$DOWNLOAD kB/s   $BLUE$UPLOAD_LOGO $WHITE$UPLOAD kB/s"
fi
