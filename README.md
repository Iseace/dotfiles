# dotfiles

Configuración de mi Arch Linux con Hyprland, administrada con [GNU Stow](https://www.gnu.org/software/stow/).

## Contenido

| Paquete | Qué incluye |
|---|---|
| `hypr` | Hyprland (config en Lua), hyprpaper, scripts y wallpaper |
| `waybar` | Barra, estilos y scripts (clima, música, micrófono) |
| `kitty` | Terminal |
| `mako` | Notificaciones |
| `rofi` | Lanzador y menú de apagado |
| `swaylock` | Pantalla de bloqueo |
| `bash`, `zsh`, `fish` | Shells (zsh con powerlevel10k y catppuccin) |
| `git` | Alias y opciones de git |
| `gtk`, `qt`, `nwg`, `xsettingsd` | Temas GTK/Qt y monitores |
| `cava`, `flameshot`, `htop`, `micro`, `neofetch` | Utilidades |
| `xdg` | Apps predeterminadas y carpetas de usuario |

`pkglist-pacman.txt` y `pkglist-aur.txt` tienen los paquetes instalados explícitamente.

## Instalación

```sh
git clone https://github.com/Iseace/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh              # enlaza todos los paquetes
./install.sh hypr waybar  # o solo algunos
./install.sh --packages   # instala también los paquetes de pacman y AUR
```

Los archivos que ya existían se mueven a `~/.dotfiles-backup-<fecha>/` antes de crear los symlinks. Si `stow` falla, se restauran solos.

Cierra Flameshot antes de instalar: reescribe su configuración al instante y choca con el symlink.

## Valores locales (no se versionan)

| Archivo | Contenido |
|---|---|
| `~/.gitconfig.local` | `[user]` con nombre y correo |
| `~/.config/waybar/weather.env` | `KEY="..."`, llave de [OpenWeatherMap](https://openweathermap.org/api) |

`install.sh` crea plantillas de ambos si no existen.
