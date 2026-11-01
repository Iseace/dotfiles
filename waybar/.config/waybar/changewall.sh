#!/bin/bash

wallpapers=$(ls ~/wallpapers/)

selected=$(echo -e $wallpapers | tr " " "\n" | rofi -dmenu -theme ~/.config/rofi/config.rasi)

if [$selected -eq ""]; then
    exit 0
fi

swww img ~/wallpapers/$selected --transition-fps 75 --transition-type wipe --transition-duration 2
