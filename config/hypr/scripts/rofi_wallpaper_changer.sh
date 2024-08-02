#!/usr/bin/bash

TEMP=/tmp/current_wall
files=(/home/alien/Downloads/gruvwalls/*)
hypr=~/.config/hypr
scripts=$hypr/scripts

# Generate the list of wallpapers
wallpapers=$(printf "%s\n" "${files[@]}")

# Show the list using Rofi and capture the selected wallpaper
selected=$(echo "$wallpapers" | rofi -dmenu -i -p "Select Wallpaper:")

# Check if a wallpaper was selected
if [ -n "$selected" ]; then
    # Find the index of the selected wallpaper
    index=$(printf "%s\n" "${files[@]}" | grep -n "^$selected$" | cut -d: -f1)
    index=$((index - 1)) # Convert to zero-based index

    # Update the TEMP file with the new index
    echo $index > $TEMP

    # Set the selected wallpaper
    $scripts/wall "$selected"
fi
