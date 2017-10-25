#!/bin/bash

REPLY=$(cat /sys/class/backlight/intel_backlight/brightness)
ICON=""

COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

if [ "$REPLY" -ge 1 -a "$REPLY" -le 93 ];
then
   echo "$COLOR$ICON $WHITE 1"
elif [ "$REPLY" -ge 94 -a "$REPLY" -le 187 ];
then
   echo "$COLOR$ICON $WHITE 2"
elif [ "$REPLY" -ge 188 -a "$REPLY" -le 281 ];
then
   echo "$COLOR$ICON $WHITE 3"
elif [ "$REPLY" -ge 282 -a "$REPLY" -le 374 ];
then
   echo "$COLOR$ICON $WHITE 4"
elif [ "$REPLY" -ge 375 -a "$REPLY" -le 468 ];
then
   echo "$COLOR$ICON $WHITE 5"
elif [ "$REPLY" -ge 469 -a "$REPLY" -le 562 ];
then
   echo "$COLOR$ICON $WHITE 6"
elif [ "$REPLY" -ge 563 -a "$REPLY" -le 655 ];
then
   echo "$COLOR$ICON $WHITE 7"
elif [ "$REPLY" -ge 656 -a "$REPLY" -le 749 ];
then
   echo "$COLOR$ICON $WHITE 8"
elif [ "$REPLY" -ge 750 -a "$REPLY" -le 843 ];
then
   echo "$COLOR$ICON $WHITE 9"
elif [ "$REPLY" -ge 844 -a "$REPLY" -le 937 ];
then
   echo "$COLOR$ICON $WHITE 10"
fi
