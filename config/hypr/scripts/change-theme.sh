#!/bin/bash

# Define an array of GTK themes and icon themes
GTK_THEMES=("Catppuccin-Dark" "Everforest-Dark" "Gruvminimal")
ICON_THEMES=("Rose-Pine" "Gruvbox-Plus-Dark" "Gruvbox-Plus-Dark")

# Get the current index from a file (or default to 0)
INDEX_FILE="$HOME/.theme_index"
INDEX=$(cat "$INDEX_FILE" 2>/dev/null || echo "0")

# Apply the next theme in the list
GTK_THEME="${GTK_THEMES[$INDEX]}"
ICON_THEME="${ICON_THEMES[$INDEX]}"

gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"

# Apply the changes using nwg-look
nwg-look -a

# Increment the index, looping back to 0 if at the end
NEXT_INDEX=$(( (INDEX + 1) % ${#GTK_THEMES[@]} ))
echo "$NEXT_INDEX" > "$INDEX_FILE"

echo "GTK theme set to $GTK_THEME and icon theme set to $ICON_THEME"
