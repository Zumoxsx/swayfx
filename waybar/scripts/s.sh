#!/bin/bash

CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/style.css"
COLORS="$HOME/.config/wofi/colors"
MUSIC_DIR="$HOME/Music"

# Asociar ruta escapada con ruta real
declare -A path_map
choices=""

# Buscar solo archivos .mp3 y preparar lista escapada para wofi
while IFS= read -r path; do
    # Escapar solo lo necesario (para GTK)
    escaped_path="${path//&/&amp;}"
    path_map["$escaped_path"]="$path"
    choices+="$escaped_path"$'\n'
done < <(find "$MUSIC_DIR" -type f -iname "*.mp3")

# Mostrar selector
selection=$(echo "$choices" | wofi --dmenu --prompt "  Song:" --conf "$CONFIG" --style "$STYLE" --color "$COLORS")

# Salir si no se selecciona nada
[ -z "$selection" ] && exit 0

# Revertir escape de &
selection="${selection//&amp;/&}"
real_path="${path_map[$selection]}"

# Ruta relativa para MPD
relative_path="${real_path#$MUSIC_DIR/}"

# Reproducir
mpc clear
mpc add "$relative_path"
mpc play
