#!/usr/bin/env bash
# Instala los dotfiles con GNU Stow.
# Uso: ./install.sh [--packages] [paquete ...]
#   --packages  instala antes los paquetes de pkglist-pacman.txt y pkglist-aur.txt
#   sin nombres de paquete se instalan todos
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")"
DOTFILES=$PWD
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

if [[ "${1:-}" == "--packages" ]]; then
    shift
    sudo pacman -S --needed - < pkglist-pacman.txt
    command -v yay >/dev/null && yay -S --needed - < pkglist-aur.txt
fi

command -v stow >/dev/null || { echo "Falta stow: sudo pacman -S stow"; exit 1; }

if [[ $# -gt 0 ]]; then
    PKGS=("$@")
else
    mapfile -t PKGS < <(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' -printf '%f\n' | sort)
fi

# Respalda los archivos reales que chocarían con los symlinks
for pkg in "${PKGS[@]}"; do
    while IFS= read -r -d '' f; do
        rel=${f#"$pkg"/}
        target="$HOME/$rel"
        if [[ -e "$target" && ! -L "$target" ]]; then
            mkdir -p "$BACKUP/$(dirname "$rel")"
            mv "$target" "$BACKUP/$rel"
        fi
    done < <(find "$pkg" -type f -print0)
done
[[ -d "$BACKUP" ]] && echo "Respaldo de los archivos anteriores: $BACKUP"

# Si stow falla, regresa los archivos respaldados a su lugar
restore() {
    echo "stow falló; restaurando archivos desde $BACKUP"
    [[ -d "$BACKUP" ]] && cp -a "$BACKUP"/. "$HOME"/
    exit 1
}

# --no-folding: enlaza archivo por archivo, así los archivos locales (weather.env) no terminan dentro del repo
stow --no-folding -v -d "$DOTFILES" -t "$HOME" "${PKGS[@]}" || restore

# Plantillas de valores locales que no se versionan
if [[ ! -f "$HOME/.gitconfig.local" ]]; then
    printf '[user]\n\tname = Tu Nombre\n\temail = tu@correo.com\n' > "$HOME/.gitconfig.local"
    echo "Edita ~/.gitconfig.local con tu nombre y correo"
fi
if [[ ! -f "$HOME/.config/waybar/weather.env" ]]; then
    mkdir -p "$HOME/.config/waybar"
    echo 'KEY="tu_llave_de_openweathermap"' > "$HOME/.config/waybar/weather.env"
    chmod 600 "$HOME/.config/waybar/weather.env"
    echo "Pon tu llave de OpenWeatherMap en ~/.config/waybar/weather.env"
fi

echo "Listo."
