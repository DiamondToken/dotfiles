#!/bin/sh

#setxkbmap -model pc61 -layout us,ru -variant ,, -option grp:alt_space_toggle &

fcitx5 &
clipmenud &
sxhkd &
dunst &
chromium &
dwmblocks &
emacs &
#transmission-daemon &
"$HOME"/.screenlayout/dh.sh &
"$HOME"/.fehbg &
telegram-desktop &
picom &

xset -dpms s off &


while true; do
    dwm 2> ~/.dwm.log
    #dwm >/dev/null 2>&1
done

dwm
