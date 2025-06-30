#!/bin/sh

CONFIG="$HOME/.config/wofi/configp"
STYLE="$HOME/.config/wofi/stylep.css"
#COLORS="$HOME/.config/wofi/colors"

# Define las opciones con nombres legibles y acciones claras
OPTIONS=$(cat <<EOF
 ⏻
 
 
 󰒲
EOF
)

# Mostrar menú con Wofi
CHOICE=$(echo "$OPTIONS" | wofi --dmenu --prompt "Goodbye Zumo" \
    -x 750px \
    -y 25px \
    -w 4 \
    --conf "$CONFIG" \
    --style "$STYLE" \
#    --color "$COLORS" \
)

# Filtra solo el ícono elegido
ACTION=$(echo "$CHOICE" | awk '{print $1}')

# Ejecuta acción según ícono
case "$ACTION" in
    ⏻)
        poweroff
        ;;
    )
        reboot
        ;;
    )
        ~/.config/waybar/scripts/l.sh
        ;;
    󰒲)
        systemctl suspend
        ;;
    *)
        exit  
        ;;
esac

