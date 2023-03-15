#!/bin/sh

pgrep -x dmenu && exit

mountable=$(lsblk -lp | grep "part $" | awk '{print $1, "(" $4 ")"}')
[ "$mountable" = "" ] && exit 1
chosen=$(echo "$mountable" | dmenu -i -p "Mount which drive?" | awk '{print $1}')

[ "$chosen" = "" ] && exit 1

dirs=$(find /mnt /media /mount /home /usb -type d -maxdepth 3 2>/dev/null)
mountpoint=$(echo "$dirs" | dmenu -i -F -p "Type in mount point")

if [ ! -d $mountpoint ]; then
	mkdir $mountpoint
fi	

#SUDO_ASKPASS=/usr/bin/ssh-askpass sudo -A mount $chosen $mountpoint 

sudo mount $chosen $mountpoint && notify-send "$chosen mounted to $mountpoint"
