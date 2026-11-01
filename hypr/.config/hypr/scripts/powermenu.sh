#!/bin/bash

# Options
shutdown='󰐥 Shutdown'
reboot='󰜉 Reboot'
lock=' Lock'
suspend='󰤄 Sleep'
logout='󰗼 Logout'


# Actions
chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu -p "Power Menu" -theme ~/.config/rofi/powermenu.rasi)
case ${chosen} in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
		swaylock
        ;;
    $suspend)
		systemctl suspend && swaylock 
        ;;
    $logout)
		hyprctl dispatch exit 0
        ;;
esac
