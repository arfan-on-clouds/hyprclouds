#!/bin/bash

# Function to get the current sink information
get_default_sink_info() {
    pactl list sinks | grep -A 15 'State: RUNNING'
}

# Function to get current mute state
get_mute_state() {
    get_default_sink_info | grep 'Mute' | awk '{print $2}'
}

# Function to get current volume
get_volume() {
    get_default_sink_info | grep 'Volume:' | head -n 1 | awk '{print $5}' | tr -d '%'
}

# Function to set volume and ensure it's applied
set_volume() {
    local vol="$1"
    pactl set-sink-volume @DEFAULT_SINK@ "${vol}%"
    sleep 0.1  # Small delay to ensure volume is applied
}

VOLUME_FILE="$HOME/.current_volume"
DEFAULT_VOLUME=50  # Default volume if no saved volume exists

muted=$(get_mute_state)
current_volume=$(get_volume)

if [ "$muted" = "yes" ]; then
    # Unmuting
    if [ -f "$VOLUME_FILE" ] && [ -s "$VOLUME_FILE" ]; then
        restored_volume=$(cat "$VOLUME_FILE")
        # Verify restored volume is a valid number between 0 and 100
        if [[ "$restored_volume" =~ ^[0-9]+$ ]] && [ "$restored_volume" -ge 0 ] && [ "$restored_volume" -le 100 ]; then
            set_volume "$restored_volume"
        else
            set_volume "$DEFAULT_VOLUME"
        fi
    else
        set_volume "$DEFAULT_VOLUME"
    fi
    pactl set-sink-mute @DEFAULT_SINK@ 0
else
    # Muting
    echo "$current_volume" > "$VOLUME_FILE"
    pactl set-sink-mute @DEFAULT_SINK@ 1
fi