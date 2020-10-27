#!/bin/bash

COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

RAM_HEAD="RAM"

RAM_PERCENT=$(sar -r 1 1 | sed -n 5p | awk '{print $4}')

CACHE_HEAD="Cache"
CACHE_FOUND=$(sar -r 1 1 | sed -n 5p | awk '{print $6}')
let "CACHE_KB=$CACHE_FOUND/1000"

BUFFER_HEAD="Buffer"
BUFFER_FOUND=$(sar -r 1 1 | sed -n 5p | awk '{print $5}')
let "BUFFER_KB=$BUFFER_FOUND/1000"
UNIT="M"

echo "$COLOR$RAM_HEAD  $WHITE$RAM_PERCENT%   $COLOR$CACHE_HEAD  $WHITE$CACHE_KB$UNIT   $COLOR$BUFFER_HEAD  $WHITE$BUFFER_KB$UNIT"
