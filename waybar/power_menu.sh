#!/bin/bash

options="󰓅 Performance\n󰾅 Balanced\n󰾆 Power Saver"

# we use -drun-display-format to clear the internal label
# and -theme-str to specifically hide the entry placeholder
chosen="$(echo -e "$options" | rofi -dmenu -p "" \
    -theme-str 'window { width: 12%; location: north; y-offset: 45; border: 2px; border-radius: 15px; border-color: #2d263d; background-color: #1a1624; }' \
    -theme-str 'mainbox { children: [ listview ]; }' \
    -theme-str 'listview { lines: 3; scrollbar: false; padding: 5px; }' \
    -theme-str 'entry { placeholder: ""; }' \
    -theme-str 'element { padding: 8px; border-radius: 10px; }')"

case $chosen in
    *Performance) powerprofilesctl set performance ;;
    *Balanced) powerprofilesctl set balanced ;;
    *Power\ Saver) powerprofilesctl set power-saver ;;
esac
