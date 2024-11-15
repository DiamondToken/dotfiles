#!/bin/sh

[ -n "$SSH_TTY" -o -n "$SSH_CLIENT" ] && {
       exit 0
}    

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
unclutter &
mpris-proxy &

xset -dpms s off &


while true; do
    dwm 2> ~/.dwm.log
    #dwm >/dev/null 2>&1
done

dwm
