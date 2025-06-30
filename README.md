# SwayFX Dotfiles

My little **swayfx** dotfiles, inspired by [gh0stzk](https://github.com/gh0stzk/dotfiles?tab=readme-ov-file#-the-themes) theme z0mbi3. It's not ready yet but you can try it...

## 🧰 Aplicaciones incluidas

| Herramienta | Uso | 
|------------|-----|
| [SwayFX](https://github.com/WillPower3309/swayfx) | Compositor Wayland con efectos |
| [Waybar](https://github.com/Alexays/Waybar) | Barra de estado altamente personalizable | 
| [Alacritty](https://github.com/alacritty/alacritty) | Terminal rápida y con soporte para GPU |
| [Wofi](https://hg.sr.ht/~scoopta/wofi) | Lanzador de aplicaciones estilo rofi para Wayland |
| [Mako](https://github.com/emersion/mako) | Notificador para Wayland |
| [Neovim](https://neovim.io) | Editor de texto avanzado |
| [Ranger](https://github.com/ranger/ranger) | Navegador de archivos en la terminal |
| [LSD](https://github.com/lsd-rs/lsd) | `ls` mejorado con iconos |
| [MPD](https://www.musicpd.org) | Música |

---
## 🖼️ Capturas de pantalla

### Escritorio completo
![all](images/all.png)

### Neovim
![nvim](images/nvim.png)

### Power menu
![power](images/power.png)

### Wofi
![wofi](images/wofi.png)

### Music
![select_music](images/select_music.png)

### Notificación de música (Mako)
![ntf_music](images/ntf_music.png)

### Ranger
![ranger](images/ranger.png)

### Navegador
![browser](images/browser.png)

---

## 🎹 Atajos de teclado personalizados

### 🪟 SwayFX

| Combinación           | Acción                                                    |
|-----------------------|-----------------------------------------------------------|
| `Super + Enter`       | Abrir terminal                                   |
| `Super + D`           | Lanzar menú de apps        |
| `Super + P`           | Selector de playlist            |
| `Super + Shift + P`   | Actualiza  playlist              |
| `Super + M`           | Selector de canciones                                       |
| `Super + L`           | Bloquea la pantalla)                    |
| `Super + Q`           | Cerrar ventana                                            |
| `Super + Shift + R`   | Recargar configuración de Sway                            |
| `Super + Shift + E`   | Salir de Sway con confirmación (ventana swaynag)          |
| `Super + ←/↓/↑/→`     | Mover el foco entre ventanas                              |
| `Super + Shift + ←/↓/↑/→` | Mover la ventana actual                               |
| `Super + 1...5`       | Cambiar de workspace                                      |
| `Super + Shift + 1...5` | Mover ventana al workspace correspondiente              |
| `Super + B`           | Dividir horizontalmente (splith)                          |
| `Super + V`           | Dividir verticalmente (splitv)                            |
| `Super + F`           | Alternar pantalla completa                                |
| `Super + Shift + Espacio` | Alternar modo flotante                              |
| `Super + Espacio`     | Alternar foco entre ventana flotante/tiling               |
| `Super + A`           | Foco al contenedor padre                                  |
| `Super + O`           | Alternar modo de layout                                   |
| `Super + X`           | Enviar ventana al scratchpad                              |
| `Super + Z`           | Mostrar scratchpad                                        |
| `Super + R`           | Entrar al modo de resize                                  |
| `XF86Audio...`        | Control de volumen y micrófono                            |
| `XF86MonBrightness...`| Control de brillo de pantalla                             |
| `Print`               | Captura de pantalla del HDMI                              |
| `Shift + Print`       | Captura de pantalla del eDP                               |
| `Super + Ctrl + ←/→`  | Canción anterior / siguiente en MPD                       |
| `Super + Ctrl + ↑`    | Pausar/Reanudar música (mpc toggle)                       |
| `Super + Ctrl + ↓`    | Reproducir música (mpc play)                              |
| `Super + S`           | Detener música (mpc stop)                                 |

---

### 📝 Neovim (NvChad base con mappings personalizados)

| Combinación           | Acción                                      |
|-----------------------|---------------------------------------------|
| `Ctrl + A`            | Seleccionar todo el archivo                 |
| `Ctrl + Z`            | Buscar archivos (Telescope)                |
| `Leader + E`          | Abrir/cerrar NvimTree                       |
| `Ctrl + S`            | Guardar archivo (en todos los modos)       |
| `Leader + Y` (visual) | Copiar al portapapeles del sistema         |
| `Ctrl + E`            | Salir de Neovim sin guardar                 |
| `Ctrl + ←/↓/↑/→`      | Mover entre splits                          |
| `Ctrl + Shift + →`    | Crear split vertical                        |
| `Ctrl + Shift + ↓`    | Crear split horizontal                      |
| `Ctrl + Alt + ↑/↓/←/→`| Redimensionar splits                        |
| `Leader + R`          | Recargar configuración de Neovim           |
| `Esc` en terminal     | Salir del modo terminal (insert → normal)  |

---

## ⚠️ **Waybar solo aparece en el monitor HDMI (HDMI-A-1)**

 Esta configuración de Waybar está pensada para usarse únicamente en un **monitor externo (HDMI-A-1)**.

 Si usas un solo monitor (como `eDP-1` en una laptop sin pantalla adicional), la barra **no se mostrará** por defecto.

 🔧 Para cambiar esto:

 1. Abre el archivo `~/.config/waybar/config`.
 2. Busca la sección `"output": "HDMI-A-1"` y cámbiala a `"output": "eDP-1"` o elimínala para que funcione en cualquier pantalla.

 También puedes duplicar la configuración si quieres una barra en ambos monitores.


## 🏗️ Instalación

> ⚠️ Este setup asume que usas una distro basada en Arch Linux. Aún así, puede adaptarse fácilmente.

### 1. Clona el repositorio

```bash
git clone https://github.com/Zumoxsx/swayfx.git ~/dotfiles
cd ~/dotfiles
sudo pacman -S sway waybar alacritty wofi mako neovim ranger mpd lsd
# AUR:
yay -S swayfx-git
cp -r sway ~/.config/
cp -r waybar ~/.config/
cp -r alacritty ~/.config/
cp -r wofi ~/.config/
cp -r mako ~/.config/
cp -r nvim ~/.config/
cp -r ranger ~/.config/
cp -r mpd ~/.config/
cp -r lsd ~/.config/
cp -r fonts /usr/share/fonts
fc-cache -fv
cp -r icons ~/.icons
reboot
```
