#!/bin/bash

# Function to toggle eww widgets
toggle_widget() {
    local widget="$1"
    eww open "$widget" --toggle
}

# Widgets to toggle
widgets=("corner1" "corner2" "taskbar-left")

# Toggle each widget
for widget in "${widgets[@]}"; do
    toggle_widget "$widget"
done
