#/bin/sh

[ "$(echo -e "No\nYes" | dmenu -i -p "$1")" = "Yes" ] && $2

#if [ $(echo -e "No\nYes" | dmenu -i -p "$1") == "Yes" ]
#then
#	$2
#fi
