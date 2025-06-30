#! /bin/bash 

pkill swaybg
pkill mako
swaybg -i /home/zumo/.config/sway/wallpapers/wallpaper.jpg &
mako &
systemctl --user restart mpd
mpc update
