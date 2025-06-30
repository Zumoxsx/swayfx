#!/bin/bash

CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/style.css"
# Buscar playlists sin extensión .m3u
playlist=$(ls ~/.config/mpd/playlists/ | sed 's/\.m3u$//' | wofi --dmenu --prompt "󰼄 Playlist:" --conf ${CONFIG} --style ${STYLE})

# Si no se selecciona nada, salir
[ -z "$playlist" ] && exit 0

# Cargar y reproducir
mpc clear
mpc load "$playlist"
mpc play
