#!/bin/sh
# exec setxkbmap -model pc61 -layout us,ru -variant ,, -option grp:alt_space_toggle &

# export XDG_SESSION_TYPE=x11

# GTK_IM_MODULE=fcitx
# QT_IM_MODULE=fcitx
# XMODIFIERS=@im=fcitx

GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus

fcitx5 &
clipmenud &
sxhkd &
dunst &
chromium &
dwmblocks &
emacs &
#transmission-daemon &
/home/diamond/.screenlayout/dh.sh &
/home/diamond/.fehbg &
telegram-desktop &
picom &

xset -dpms s off &

while true; do
    # Log stderror to a file
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done

dwm
# export DESKTOP_SESSION=plasma
# exec startplasma-x11
# xmonad
