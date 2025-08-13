xrandr --output HDMI-0 --auto --right-of HDVI-D-0 &
xsetroot -solid '#111217' &
xsetroot -cursor_name left_ptr &
picom &

sxhkd &
slstatus &

while :; do dwm; done
