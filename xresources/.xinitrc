#!/bin/sh
#exec setxkbmap -model pc61 -layout us,ru -variant ,, -option grp:alt_space_toggle &

#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11
#exec gnome-session

GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus

fcitx5 &

clipmenud &
sxhkd &
dunst &
transmission-daemon &
/home/diamond/.screenlayout/d.sh &
/home/diamond/.fehbg &
telegram-desktop &
# picom &

dwmblocks &

while true; do
	dwm
done
