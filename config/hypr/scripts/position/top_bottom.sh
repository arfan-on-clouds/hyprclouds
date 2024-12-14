#!/bin/bash

# Define the paths to the configuration files
WAYBAR_CONFIG="/home/alien/.config/waybar/config"
SWAYNC_CONFIG="/home/alien/.config/swaync/config.json"
CURRENT_CONFIG="/home/alien/.config/waybar/current_config"

# Function to get the current position from the Waybar configuration
get_current_position() {
    grep -oP '"position": "\K(top|bottom)' "$WAYBAR_CONFIG"
}

# Function to update the position in the Waybar configuration
update_waybar_position() {
    local new_position=$1
    sed -i "s/\"position\": \"top\"/\"position\": \"$new_position\"/" "$WAYBAR_CONFIG"
    sed -i "s/\"position\": \"bottom\"/\"position\": \"$new_position\"/" "$WAYBAR_CONFIG"
    pkill waybar
    waybar &
}

# Function to update the position in the SwayNC configuration
update_swaync_position() {
    local new_position=$1
    sed -i "s/\"positionY\": \"top\"/\"positionY\": \"$new_position\"/" "$SWAYNC_CONFIG"
    sed -i "s/\"positionY\": \"bottom\"/\"positionY\": \"$new_position\"/" "$SWAYNC_CONFIG"
}

# Get the current position
current_position=$(get_current_position)

# Determine the new position
if [ "$current_position" = "top" ]; then
    new_position="bottom"
else
    new_position="top"
fi

# Update both configurations to the new position
update_waybar_position "$new_position"
update_swaync_position "$new_position"

# Restart SwayNC
pkill swaync
swaync &
