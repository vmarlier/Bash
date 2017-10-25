#!/bin/bash

COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

PID=$(ps ax | pgrep dockerd)

if [ -z "$PID" ]; then
				echo ""
else
				echo ""
fi
