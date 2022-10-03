#!/usr/bin/sh

cap="$(cat /sys/class/power_supply/BAT0/capacity)"
cap_level="$(cat /sys/class/power_supply/BAT0/capacity_level)"


echo "$cap% $cap_level"
