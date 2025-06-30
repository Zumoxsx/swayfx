#!/bin/bash

# --- CONFIGURACIÓN ---
# Directorio de origen de los dotfiles (dentro de ~/.config)
SOURCE_BASE_DIR="$HOME/.config"

# Directorio de destino para el backup
DEST_DIR="$HOME/dotfiles" # Si es un typo y quieres "dotfiles", cambia a "$HOME/dotfiles"

# Lista de subcarpetas a respaldar desde $SOURCE_BASE_DIR
# Asegúrate de que los nombres coincidan exactamente con tus carpetas.
# Los espacios en los nombres de carpeta se manejan correctamente con las comillas dobles.
DOTFILES_TO_BACKUP=(
    "alacritty"
    "lsd"
    "mako"
    "mpd"
    "nvim"
    "ranger"
    "sway"
    "waybar"
    "wofi"
)

# --- FIN DE CONFIGURACIÓN ---

echo "Iniciando el backup de dotfiles..."
echo "Origen: $SOURCE_BASE_DIR"
echo "Destino: $DEST_DIR"

# Crear el directorio de destino si no existe
mkdir -p "$DEST_DIR" || { echo "Error: No se pudo crear o acceder al directorio de destino: $DEST_DIR"; exit 1; }

# Contador para el resumen
BACKUP_COUNT=0
ERROR_COUNT=0

# Iterar sobre cada carpeta a respaldar
for folder in "${DOTFILES_TO_BACKUP[@]}"; do
    SOURCE_PATH="$SOURCE_BASE_DIR/$folder"
    DEST_PATH="$DEST_DIR/$folder"

    echo "Copiando: $SOURCE_PATH -> $DEST_PATH"

    # Verificar si la carpeta de origen existe
    if [ ! -d "$SOURCE_PATH" ]; then
        echo "Advertencia: La carpeta de origen '$SOURCE_PATH' no existe. Saltando."
        ERROR_COUNT=$((ERROR_COUNT + 1))
        continue
    fi

    # Realizar la copia recursiva
    # -r: recursivo (copia directorios y sus contenidos)
    # -u: update (copia solo si el origen es más nuevo que el destino o si el destino no existe)
    # -v: verbose (muestra los archivos que se están copiando, como en tu ejemplo)
    # -p: preserve (preserva modos, propiedad y timestamps)
    cp -rpu "$SOURCE_PATH" "$DEST_DIR/"
    
    # Verificar si la copia fue exitosa (el comando 'cp' devuelve 0 si tiene éxito)
    if [ $? -eq 0 ]; then
        echo "  - Backup de '$folder' completado."
        BACKUP_COUNT=$((BACKUP_COUNT + 1))
    else
        echo "  - Error: Falló el backup de '$folder'."
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
done

echo "" # Nueva línea para separar el resumen
echo "--- Resumen del Backup ---"
echo "Carpetas respaldadas con éxito: $BACKUP_COUNT"
echo "Carpetas con errores/advertencias: $ERROR_COUNT"
echo "Backup finalizado."

# Puedes añadir una notificación de escritorio si lo deseas (requiere 'notify-send')
# if command -v notify-send &> /dev/null; then
#     if [ "$ERROR_COUNT" -eq 0 ]; then
#         notify-send "Backup de Dotfiles" "¡Backup completado con éxito! ($BACKUP_COUNT carpetas)"
#     else
#         notify-send -u critical "Backup de Dotfiles" "Backup completado con errores. Revisa el log."
#     fi
# fi

exit 0
