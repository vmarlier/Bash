#!/bin/bash

COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

CPU_HEAD="CPU"

CPU_IDLE=$(sar -u -P ALL 1 1 | sed -n 4p | awk '{print $8}')
CPU_AROUND=$(printf '%.*f\n' 0 $CPU_IDLE)
let "CPU_USAGE=100-$CPU_AROUND"

#CPU_FREQUENCY=$(sar -m CPU -P ALL 1 1 | sed -n 4p | awk '{print $3}' | cut -d ',' -f 1)

#CPU_FREQ_UNIT="MHz"

CPU_TEMP_LOGO=""
CPU_TEMP=$(acpi -t | awk '{print $4}')
CPU_TEMP_UNIT="°C"

echo "$COLOR$CPU_HEAD  $WHITE$CPU_USAGE%  $COLOR$CPU_TEMP_LOGO  $WHITE[$CPU_TEMP$CPU_TEMP_UNIT]"
