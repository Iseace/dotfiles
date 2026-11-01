#!/bin/bash
# Avisa con mako cuando la batería baja y no está conectada.
# Aviso normal en LOW y urgente (no se cierra solo) en CRITICAL.

BAT=/sys/class/power_supply/BAT0
LOW=20
CRITICAL=10
INTERVAL=60

# Evita que corran dos copias si Hyprland se recarga
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/battery-notify.lock"
flock -n 9 || exit 0

notified=""
id=""

while true; do
    capacity=$(cat "$BAT/capacity")
    status=$(cat "$BAT/status")

    if [ "$status" = "Discharging" ]; then
        if [ "$capacity" -le "$CRITICAL" ] && [ "$notified" != "critical" ]; then
            id=$(notify-send -p -u critical -h string:x-canonical-private-synchronous:battery \
                "Batería crítica: ${capacity}%" "Conecta el cargador ya")
            notified="critical"
        elif [ "$capacity" -le "$LOW" ] && [ "$capacity" -gt "$CRITICAL" ] && [ -z "$notified" ]; then
            id=$(notify-send -p -u normal -h string:x-canonical-private-synchronous:battery \
                "Batería baja: ${capacity}%" "Conecta el cargador pronto")
            notified="low"
        fi
    else
        # Al conectar se reinicia, y se cierra el aviso si seguía abierto
        if [ -n "$notified" ]; then
            [ -n "$id" ] && makoctl dismiss -n "$id" 2>/dev/null
            notified=""
            id=""
        fi
    fi

    sleep "$INTERVAL"
done
