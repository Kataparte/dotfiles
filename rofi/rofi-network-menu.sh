#!/bin/bash

# 1. Get ONLY the active SSID (Instant)
active_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)

# 2. Get saved SSIDs from DISK (This bypasses the 5s hardware scan entirely)
# 'connection show' reads files, it does not scan the airwaves
other_ssids=$(nmcli -t -f NAME connection show | grep -v "^$active_ssid$" | sort -u)

# 3. Build the list (No leading \n to fix the empty gap)
if [ -n "$active_ssid" ]; then
    menu_list="󰷊 Connected: $active_ssid"
else
    menu_list="󰈀 No Connection"
fi

menu_list="$menu_list\n$other_ssids\n󰒓 Network Settings"

# 4. Show the menu
chosen=$(echo -e "$menu_list" | rofi -dmenu -i -theme ~/.config/rofi/network.rasi)

# 5. Logic
if [[ "$chosen" == *"Network Settings"* ]]; then
    nm-connection-editor
elif [ -n "$chosen" ]; then
    ssid_to_connect=$(echo "$chosen" | sed 's/󰷊 Connected: //')
    nmcli connection up "$ssid_to_connect"
fi
