#!/bin/bash

if [ -n "$1" ]; then
				find . ! -name $1 -type f -exec rm -f {} +
elif [ -n "$2" ]; then
				find . ! -name $1 ! -name $2 -type f -exec rm -f {} +
elif [ -n "$3" ]; then
				find . ! -name $1 ! -name $2 ! -name $3 -type f -exec rm -f {} +
else
				echo "Require minimum 1 argument (3 max)"
				exit
fi
