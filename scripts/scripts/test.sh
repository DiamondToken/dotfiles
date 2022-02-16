#!/bin/sh

dirs=$(find /mnt /media /mount /home -type d -maxdepth 3 2>/dev/null)

folder=$(echo "$dirs" | dmenu -i -p "govno")

echo "'$folder'"
