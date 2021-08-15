#!/bin/bash

pgrep -x dmenu && exit

nunmountable=$(lsblk -lp | grep "/dev/sd[b-z]" | grep "part" | awk '{print $4,"",$7}' | awk '{if ($2) print $2,"(" $1 ")"}')

[[ "$nunmountable" = "" ]] && exit 1

chosen=$(echo "$nunmountable" | dmenu -i -p "Unmount which drive?" | awk '{print $1}')

[[ "$chosen" = "" ]] && exit 1

sudo umount $chosen && notify-send "$chosen unmounted"

rm -d $chosen

exit 1
