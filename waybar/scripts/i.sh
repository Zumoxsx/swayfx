#!/bin/bash

# Salir si mpd no está corriendo
pgrep -x mpd >/dev/null || exit 0

# Obtener título
title=$(mpc --format '%title%' current)
icon="󰎇 "
# Si no hay título, usar el nombre del archivo limpio
file=$(mpc --format '%file%' current)
title="${file##*/}"                     # Quita ruta
title="${title%.*}"                     # Quita extensión
title="${title##*- }"                   # Quita "Artista - " si existe
title="${title##[0-9][0-9]*[ _.-]}"     # Quita numeración tipo "01 -"


[ -n "$title" ] && echo "$title"
music="$icon$title"
 notify-send  -u normal "$music"

