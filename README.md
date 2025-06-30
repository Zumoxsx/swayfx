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
