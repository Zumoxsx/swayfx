#!/bin/bash

# Guarda el nombre de la última canción reproducida (limpio)
LAST_SONG_CLEAN=""

# Ícono musical Unicode (puedes cambiarlo si usas otro)
MUSIC_ICON="󰎇 " # ¡Asegúrate de incluir un espacio después del ícono si lo deseas!

# Bucle infinito para monitorear MPD
while true; do
    # Obtener el nombre del archivo actual de MPD
    CURRENT_FILE=$(mpc --format '%file%' current)

    # Si no hay un archivo actual (MPD no está reproduciendo nada), salta la iteración
    if [ -z "$CURRENT_FILE" ]; then
        LAST_SONG_CLEAN="" # Resetear si no hay canción para evitar notificaciones fantasmas
        sleep 1
        continue
    fi

    # Limpiar el nombre del archivo para la notificación
    CLEAN_SONG="${CURRENT_FILE##*/}"             # Quita ruta
    CLEAN_SONG="${CLEAN_SONG%.*}"                # Quita extensión
    CLEAN_SONG="${CLEAN_SONG##*- }"              # Quita "Artista - " si existe (espacio después del guion)
    CLEAN_SONG="${CLEAN_SONG##*-}"               # Quita "Artista-" si existe (sin espacio después del guion)
    CLEAN_SONG="${CLEAN_SONG##[0-9][0-9]*[ _.-]}" # Quita numeración tipo "01 -", "01_", "01.", etc.
    CLEAN_SONG="${CLEAN_SONG//_/ }"              # Reemplaza guiones bajos por espacios (opcional, si te gusta más legible)
    CLEAN_SONG=$(echo "$CLEAN_SONG" | sed -E 's/^[[:space:]]+|[[:space:]]+$//g') # Eliminar espacios iniciales/finales

    # Si la canción limpia actual es diferente a la última, envía una notificación
    if [ "$CLEAN_SONG" != "$LAST_SONG_CLEAN" ]; then
        if [ -n "$CLEAN_SONG" ]; then # Asegúrate de que el nombre limpio no esté vacío
            # Concatena el ícono musical al principio del nombre de la canción
            NOTIFICATION_TEXT="$MUSIC_ICON$CLEAN_SONG"

            notify-send -u normal "$NOTIFICATION_TEXT" 
            LAST_SONG_CLEAN="$CLEAN_SONG"
        fi
    fi

    # Espera un momento antes de volver a comprobar (ej. 1 segundo)
    sleep 1
done


