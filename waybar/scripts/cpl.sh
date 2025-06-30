#!/bin/bash

# Directorio base de tu música
MUSIC_BASE_DIR="/home/zumo/Music"

# Directorio donde MPD espera que estén las playlists (¡AJUSTA ESTO SI ES DIFERENTE!)
MPD_PLAYLIST_DIR="/home/zumo/.config/mpd/playlists"

# Extensiones de archivos de música que buscar (puedes añadir o quitar)
MUSIC_EXTENSIONS=("mp3" "flac" "ogg" "wav" "m4a" "aac")

# --- OPCIONES DE NOMENCLATURA DE PLAYLIST ---
# 1. PLAYLIST_NAMING_SCHEME="folder_name" (Por defecto):
#    La playlist se llamará igual que la carpeta (ej. "Vida.m3u").
#    ADVERTENCIA: Riesgo de colisiones si tienes carpetas con el mismo nombre en diferentes artistas/niveles.
# 2. PLAYLIST_NAMING_SCHEME="full_path_sanitized" (Recomendado para evitar colisiones):
#    La playlist se basará en la ruta completa, reemplazando '/' con un guion o subrayado.
#    Ej: "Canserbero_Vida.m3u" o "Canserbero-Vida.m3u" si la carpeta es ~/Music/Canserbero/Vida.
#    Esta es la opción más segura para tener nombres de playlist únicos.
PLAYLIST_NAMING_SCHEME="full_path_sanitized" # Cambia a "folder_name" si prefieres el otro esquema

# Carácter separador si usas "full_path_sanitized"
PATH_SEPARATOR="_" # O puedes usar "-"

echo "Iniciando la creación de playlists para MPD (generando archivos .m3u)..."
echo "Directorio de música base: $MUSIC_BASE_DIR"
echo "Directorio de playlists de MPD: $MPD_PLAYLIST_DIR"
echo "Esquema de nombres de playlist: $PLAYLIST_NAMING_SCHEME"

# 1. Asegurarse de que el directorio de playlists existe
mkdir -p "$MPD_PLAYLIST_DIR" || { echo "Error: No se pudo crear o acceder al directorio de playlists: $MPD_PLAYLIST_DIR"; exit 1; }

# 2. Actualizar la base de datos de MPD
echo "Actualizando la base de datos de MPD... Esto puede tomar un momento."
mpc update
echo "Esperando unos segundos para que la base de datos se actualice..."
sleep 5 # Pequeña pausa para que MPD termine de escanear

# --- CAMBIO IMPORTANTE AQUÍ: Encontrar todos los directorios que contienen música ---
# Busca directorios que contengan al menos un archivo con las extensiones de música
# Esto es para evitar crear playlists para carpetas vacías o que solo contengan imágenes/otros archivos.
# Usamos -depth para procesar primero los directorios más profundos, útil si el nombre de playlist se basa en el nombre de la carpeta
# FIND_DIRS=$(find "$MUSIC_BASE_DIR" -type d -print0 | xargs -0 -I {} bash -c 'shopt -s nullglob; for f in "{}"/*.{'${MUSIC_EXTENSIONS[@]/%/,}'; do echo "{}"; break; done' 2>/dev/null | sort -u)

# Una forma más sencilla y robusta para listar directorios con música:
# Recorre todos los directorios y verifica si tienen archivos de música.
# Usaremos find para obtener todos los directorios y luego un bucle para procesarlos.

# Construir el array de argumentos para find (extensiones)
FIND_ARGS=()
for ext in "${MUSIC_EXTENSIONS[@]}"; do
    FIND_ARGS+=("-name" "*.${ext}")
    FIND_ARGS+=("-o")
done
# Eliminar el último "-o" que sobra
unset 'FIND_ARGS[${#FIND_ARGS[@]}-1]'

# Encontrar todos los directorios que contienen archivos de música y almacenarlos en un array
# -type f: busca archivos
# -print0: salida terminada en nulo
# -exec dirname {} \;: para cada archivo encontrado, obtener su directorio padre
# sort -u -z: ordenar y eliminar duplicados, usando nulos
# IFS= read -r -d $'\0' dir_path: leer entradas terminadas en nulo en el bucle
MAP_FILE_TO_PLAYLIST="/tmp/mpd_playlist_map_$$" # Archivo temporal para mapear rutas a nombres de playlist

# Clear the map file
> "$MAP_FILE_TO_PLAYLIST"

# Generar y almacenar los nombres de las playlists y sus rutas de origen
find "$MUSIC_BASE_DIR" -type f \( "${FIND_ARGS[@]}" \) -print0 | while IFS= read -r -d $'\0' music_file; do
    DIR_PATH=$(dirname "$music_file")

    # Asegurarse de no procesar el MUSIC_BASE_DIR mismo como una playlist
    if [[ "$DIR_PATH" == "$MUSIC_BASE_DIR" ]]; then
        continue
    fi

    # Determinar el nombre de la playlist
    PLAYLIST_NAME=""
    if [[ "$PLAYLIST_NAMING_SCHEME" == "folder_name" ]]; then
        PLAYLIST_NAME=$(basename "$DIR_PATH")
    elif [[ "$PLAYLIST_NAMING_SCHEME" == "full_path_sanitized" ]]; then
        # Obtener la ruta relativa desde MUSIC_BASE_DIR
        RELATIVE_PATH="${DIR_PATH#$MUSIC_BASE_DIR/}"
        # Santinizar el nombre: reemplazar '/' y ' ' con el separador, eliminar barras al inicio/fin
        PLAYLIST_NAME=$(echo "$RELATIVE_PATH" | sed -e "s|/|$PATH_SEPARATOR|g" -e "s| |$PATH_SEPARATOR|g" -e "s|^$PATH_SEPARATOR*||" -e "s|$PATH_SEPARATOR*$||")
    fi

    if [ -n "$PLAYLIST_NAME" ]; then
        # Almacenar la relación entre el nombre de la playlist y la ruta de la carpeta
        echo "$PLAYLIST_NAME@$DIR_PATH" >> "$MAP_FILE_TO_PLAYLIST"
    fi
done

# Procesar las entradas únicas del mapa de playlists
# Usamos sort -u para asegurarnos de que cada "PLAYLIST_NAME" se procese una sola vez
# y luego se agrupan todos los DIRECTORIOS que corresponden a ese nombre de playlist.
sort -u "$MAP_FILE_TO_PLAYLIST" | while IFS='@' read -r PLAYLIST_NAME DIR_PATH; do
    PLAYLIST_FILE="$MPD_PLAYLIST_DIR/$PLAYLIST_NAME.m3u"

    echo "Procesando playlist: '$PLAYLIST_NAME'"
    echo "  - Creando/actualizando playlist: '$PLAYLIST_FILE'"

    # Inicializar el archivo de playlist (lo truncamos)
    > "$PLAYLIST_FILE"

    # Buscar todos los archivos de música dentro de este DIR_PATH y sus subdirectorios
    # y añadir sus rutas absolutas al archivo .m3u
    find "$DIR_PATH" -type f \( "${FIND_ARGS[@]}" \) -print0 | sort -z | tr '\0' '\n' >> "$PLAYLIST_FILE"

    # Verificar si se añadió algo a la playlist
    if [ -s "$PLAYLIST_FILE" ]; then
        SONG_COUNT=$(wc -l < "$PLAYLIST_FILE")
        echo "  - Playlist '$PLAYLIST_NAME.m3u' creada/actualizada con $SONG_COUNT canciones."
    else
        echo "  - Advertencia: No se encontraron canciones de música en '$DIR_PATH' (para playlist '$PLAYLIST_NAME'). La playlist puede estar vacía."
        rm -f "$PLAYLIST_FILE" # Eliminar playlist vacía si no se encontraron canciones
    fi
done

# Limpiar archivo temporal
rm -f "$MAP_FILE_TO_PLAYLIST"

echo "Proceso de creación de playlists finalizado."
echo "Ahora puedes usar 'mpc lsplaylists' para ver las nuevas playlists."
echo "Para cargar una, usa 'mpc load <nombre_playlist_sin_m3u>' (ej. 'mpc load Canserbero_Vida')."
