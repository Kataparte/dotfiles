#!/bin/bash

# Define paths explicitly
USER_NAME="kataparte"
THEME_DIR_SYSTEM="/usr/share/hyprpanel/themes"
THEME_DIR_CUSTOM="/home/$USER_NAME/.cache/hyprpanel/themes"
WALL_DIR="/home/$USER_NAME/Pictures/wallpapers"

# 1. Get Theme List
SELECTED=$(ls $THEME_DIR_SYSTEM $THEME_DIR_CUSTOM 2>/dev/null | grep ".json" | sed 's/\.json//' | sort -u | rofi -dmenu -p "󰏘 Select Theme")

[ -z "$SELECTED" ] && exit 0

# 2. Apply HyprPanel Theme
if [ -f "$THEME_DIR_CUSTOM/$SELECTED.json" ]; then
    hyprpanel useTheme "$THEME_DIR_CUSTOM/$SELECTED.json"
else
    hyprpanel useTheme "$THEME_DIR_SYSTEM/$SELECTED.json"
fi

# 3. Find Wallpaper
WP=$(find "$WALL_DIR" -maxdepth 1 -type f -iname "$SELECTED.*" | head -n 1)

# 4. The Force-Apply logic
if [ -n "$WP" ]; then
    # Kill any hung swww processes that might be fighting
    pkill swww-daemon
    swww-daemon &
    sleep 0.5
    
    # Apply the image
    swww img "$WP" --transition-type grow --transition-duration 1.0
    
    # Force HyprPanel to register the path without its internal 'Apply' logic
    hyprpanel -p "$WP"

    matugen image "$WP"
    hyprctl reload
else
    notify-send "Theme Switcher" "No wallpaper found for $SELECTED"
fi
