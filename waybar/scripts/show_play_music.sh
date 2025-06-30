#!/bin/bash

# Verificar si MPD tiene una canción activa (reproduciendo o en pausa)
status=$(mpc status 2>/dev/null | grep -E "\[playing\]|\[paused\]")

if [[ -n "$status" ]]; then 
    echo "󰎇"
else
    echo ""
fi
