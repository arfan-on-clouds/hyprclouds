#!/bin/bash

# Function to toggle eww widgets
toggle_widget() {
    local widget="$1"
    eww open "$widget" --toggle
}

# Widgets to toggle
widgets=("powercorner-right" "powercorner-left" "powermenu")

# Toggle each widget
for widget in "${widgets[@]}"; do
    toggle_widget "$widget"
done
