#!/bin/bash

COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

SWAP_HEAD="SWAP"

SWAP_PERCENT=$(sar -S 1 1 | sed -n 4p | awk '{print $3}')


if [ "$SWAP_PERCENT" -gt 0 ]; then
				echo "$COLOR$SWAP_HEAD  $WHITE$SWAP_PERCENT%"
else
				exit
fi
