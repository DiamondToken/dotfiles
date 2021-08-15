#exec setxkbmap -model pc61 -layout us,ru -variant ,, -option grp:alt_space_toggle &

exec sxhkd &
exec dunst &
exec /home/diamond/.fehbg &
exec telegram-desktop &
#exec picom &

#exec /home/diamond/scripts/bar &
exec dwmblocks &

while true; do
	dwm
done

#exec .startdwm.sh &
