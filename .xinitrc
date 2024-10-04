# Audio
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &

# Monitors and wallpapper
xrandr --output DVI-D-0 --auto --right-of HDMI-0 &
xsetroot -solid '#111217' &
xsetroot -cursor_name left_ptr &
picom &

# Keyboard shortcuts
sxhkd &

# Suckless
exec slstatus &
exec dwm
