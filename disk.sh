#!/bin/bash - 
#===============================================================================
#
#          FILE: disk.sh
# 
#         USAGE: ./disk.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/10/2017 23:35
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

ICON=

if [ -b /dev/sde ]; then
				echo " $COLOR$ICON $WHITE sdc sdd sde"
elif [ -b /dev/sdd ]; then
				echo " $COLOR$ICON $WHITE sdc sdd"
elif [ -b /dev/sdc ]; then
				echo " $COLOR$ICON $WHITE sdc"
else
				echo ""
fi
