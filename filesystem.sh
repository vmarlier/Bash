#!/bin/bash

COLOR="%{F#55}"
WHITE="%{F#A6A6A6}"

ROOT_LOGO="/"
ROOT_USED=$(df -h | grep root | awk '{print $5}')
ROOT_FREE=$(df -h | grep root | awk '{print $4}')

HOME_LOGO=""
HOME_USED=$(df -h | grep home | awk '{print $5}')
HOME_FREE=$(df -h | grep home | awk '{print $4}')

HDD_LOGO=""
HDD_USED=$(df -h | grep sda1 | awk '{print $5}')
HDD_FREE=$(df -h | grep sda1 | awk '{print $4}')

echo "$COLOR$ROOT_LOGO  $WHITE$ROOT_FREE  [$ROOT_USED]   $COLOR$HOME_LOGO  $WHITE$HOME_FREE  [$HOME_USED]   $COLOR$HDD_LOGO  $WHITE$HDD_FREE  [$HDD_USED]"
