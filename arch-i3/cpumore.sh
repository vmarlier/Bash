#!/bin/bash

CPU0_IDLE=$(sar -u -P ALL 1 1 | sed -n 5p | awk '{print $8}')
CPU0_AROUND=$(printf '%.*f\n' 0 $CPU0_IDLE)
let "CPU0_USAGE=100-$CPU0_AROUND"

CPU1_IDLE=$(sar -u -P ALL 1 1 | sed -n 6p | awk '{print $8}')
CPU1_AROUND=$(printf '%.*f\n' 0 $CPU1_IDLE)
let "CPU1_USAGE=100-$CPU1_AROUND"

CPU2_IDLE=$(sar -u -P ALL 1 1 | sed -n 7p | awk '{print $8}')
CPU2_AROUND=$(printf '%.*f\n' 0 $CPU2_IDLE)
let "CPU2_USAGE=100-$CPU2_AROUND"

CPU3_IDLE=$(sar -u -P ALL 1 1 | sed -n 8p | awk '{print $8}')
CPU3_AROUND=$(printf '%.*f\n' 0 $CPU3_IDLE)
let "CPU3_USAGE=100-$CPU3_AROUND"

CPU0_FREQUENCY=$(sar -m CPU -P ALL 1 1 | sed -n 5p | awk '{print $3}' | cut -d ',' -f 1)
CPU0_FREQ_UNIT="MHz"

CPU1_FREQUENCY=$(sar -m CPU -P ALL 1 1 | sed -n 6p | awk '{print $3}' | cut -d ',' -f 1)
CPU1_FREQ_UNIT="MHz"

CPU2_FREQUENCY=$(sar -m CPU -P ALL 1 1 | sed -n 7p | awk '{print $3}' | cut -d ',' -f 1)
CPU2_FREQ_UNIT="MHz"

CPU3_FREQUENCY=$(sar -m CPU -P ALL 1 1 | sed -n 8p | awk '{print $3}' | cut -d ',' -f 1)
CPU3_FREQ_UNIT="MHz"

CPU0_TEMP_LOGO=""
CPU0_TEMP=$(sensors | grep 'Core 0' | cut -d '+' -f 2 | sed 's/ .*$//')

CPU1_TEMP=$(sensors | grep 'Core 1' | cut -d '+' -f 2 | sed 's/ .*$//')

CPU0=$(echo "core 0: $CPU0_USAGE% $CPU0_FREQUENCY$CPU0_FREQ_UNIT  $CPU0_TEMP_LOGO [$CPU0_TEMP]")
CPU1=$(echo "core 1: $CPU1_USAGE% $CPU1_FREQUENCY$CPU1_FREQ_UNIT  $CPU0_TEMP_LOGO [$CPU0_TEMP]")
CPU2=$(echo "core 2: $CPU2_USAGE% $CPU2_FREQUENCY$CPU2_FREQ_UNIT")
CPU3=$(echo "core 3: $CPU3_USAGE% $CPU3_FREQUENCY$CPU3_FREQ_UNIT")

echo -e "\n$CPU0\n$CPU1\n$CPU2\n$CPU3" | rofi -dmenu -p "More Detailed CPU stats" -lines 6 -location 6 -yoffset -22 -font "DejaVu Sans Ms 9" -width 30 -bw 2 -line-margin 5
