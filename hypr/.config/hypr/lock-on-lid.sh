#!/bin/bash

# Get lid state
LID_STATE=$(cat /proc/acpi/button/lid/LID*/state | awk '{print $2}')

# If the lid is closed, lock the screen
if [[ "$LID_STATE" == "closed" ]]; then
    swaylock -f
fi

