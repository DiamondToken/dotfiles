#!/usr/bin/sh

bat_file="/sys/class/power_supply/BAT0/capacity"

# cap="$(cat /sys/class/power_supply/BAT0/capacity)"
# cap_level="$(cat /sys/class/power_supply/BAT0/capacity_level)"

if [ -f bat_file ]
then
    echo "file exists"
else
    echo ""
fi


# [ -f bat_file ] && {echo "bat_file exists"} || { echo "bat_file doesn't exist"}

# [ -z cap ] && echo "" || {
#         echo "NO BAT"
#     }
# echo "$cap% $cap_level"
