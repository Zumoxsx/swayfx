#! /bin/bash 

pkill swaybg
pkill mako
sleep 1
swaybg -i /home/zumo/.config/sway/wallpapers/wallpaper.jpg &
sleep 1
mako &
sleep 1
systemctl --user restart mpd

