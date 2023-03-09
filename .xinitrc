#Audio
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &

# Monitors and wallpapper
xrandr --output DVI-D-0 --auto --right-of HDMI-0 &
feh --bg-scale $HOME/Pictures/wallpaper.jpg &
exec picom &

# Hotkeys
sxhkd &

# Suckless
exec slstatus &
exec dwm
