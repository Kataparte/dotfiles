#!/bin/bash

# 1. Switch to Workspace 9
hyprctl dispatch workspace 9

# 2. Launch Btop (Left)
hyprctl dispatch exec [workspace 9] "kitty --class sys_btop -e btop"

sleep 0.2

# 3. Launch Fastfetch (Top Right)
#hyprctl dispatch exec [workspace 9] "kitty --class sys_fetch -e sh -c 'fastfetch; read'"
#hyprctl dispatch exec [workspace 9] "kitty --class sys_fetch -o font_size=15 -o window_padding_width=30 -e sh -c 'fastfetch; read -n 1'"
hyprctl dispatch exec [workspace 9] "kitty --class sys_fetch -o font_size=15 -o window_padding_width=60 -o placement_strategy=center -e sh -c 'fastfetch; read -n 1'"

# 4. Launch Cava (Bottom Right)
hyprctl dispatch exec [workspace 9] "kitty --class sys_matrix -e cmatrix -b -C magenta -u 7 "
# Keep Cava running in the background for the Waybar
hyprctl dispatch exec [workspace 9] "kitty --class sys_visual --minimize -e cava"
