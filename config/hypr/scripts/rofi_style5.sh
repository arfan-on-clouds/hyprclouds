#!/bin/bash

# Change system wallpaper
# Assuming your original script logic for changing the wallpaper is here
WALLPAPER="$1"
# Add your logic here to set the wallpaper

# Update Rofi configuration with the new wallpaper
ROFI_WALLPAPER_PATH="/home/alien/.config/rofi/launchers/type-6/current-wallpaper.png"
COLORS_FILE="$HOME/.cache/material-you/colors.css"
ROFI_FILE="/home/alien/.config/rofi/launchers/type-6/style-9.rasi"

# Remove the old wallpaper link if it exists
if [ -L "$ROFI_WALLPAPER_PATH" ]; then
    rm "$ROFI_WALLPAPER_PATH"
fi

# Create a symbolic link to the new wallpaper
ln -sf "$WALLPAPER" "$ROFI_WALLPAPER_PATH"

# Function to convert hex color to rgba format
hex_to_rgba() {
    local hex="$1"
    local alpha="$2"
    printf "rgba(%d, %d, %d, %.1f)" 0x${hex:1:2} 0x${hex:3:2} 0x${hex:5:2} "$alpha"
}

# Extract colors from colors.css
BACKGROUND=$(grep -oP '(?<=--background: ).*' "$COLORS_FILE")
FOREGROUND=$(grep -oP '(?<=--foreground: ).*' "$COLORS_FILE")
CURSOR=$(grep -oP '(?<=--cursor: ).*' "$COLORS_FILE")

COLOR0=$(grep -oP '(?<=--color0: ).*' "$COLORS_FILE")
COLOR1=$(grep -oP '(?<=--color1: ).*' "$COLORS_FILE")
COLOR2=$(grep -oP '(?<=--color2: ).*' "$COLORS_FILE")
COLOR3=$(grep -oP '(?<=--color3: ).*' "$COLORS_FILE")
COLOR4=$(grep -oP '(?<=--color4: ).*' "$COLORS_FILE")
COLOR5=$(grep -oP '(?<=--color5: ).*' "$COLORS_FILE")
COLOR6=$(grep -oP '(?<=--color6: ).*' "$COLORS_FILE")
COLOR7=$(grep -oP '(?<=--color7: ).*' "$COLORS_FILE")
COLOR8=$(grep -oP '(?<=--color8: ).*' "$COLORS_FILE")
COLOR9=$(grep -oP '(?<=--color9: ).*' "$COLORS_FILE")
COLOR10=$(grep -oP '(?<=--color10: ).*' "$COLORS_FILE")
COLOR11=$(grep -oP '(?<=--color11: ).*' "$COLORS_FILE")
COLOR12=$(grep -oP '(?<=--color12: ).*' "$COLORS_FILE")
COLOR13=$(grep -oP '(?<=--color13: ).*' "$COLORS_FILE")
COLOR14=$(grep -oP '(?<=--color14:#!/bin/bash

# Change system wallpaper
# Assuming your original script logic for changing the wallpaper is here
WALLPAPER="$1"
# Add your logic here to set the wallpaper

# Update Rofi configuration with the new wallpaper
ROFI_WALLPAPER_PATH="/home/alien/.config/rofi/launchers/type-6/current-wallpaper.png"
COLORS_FILE="$HOME/.cache/wal/colors.json"
ROFI_FILE="/home/alien/.config/rofi/launchers/type-6/style-9.rasi"

# Remove the old wallpaper link if it exists
if [ -L "$ROFI_WALLPAPER_PATH" ]; then
    rm "$ROFI_WALLPAPER_PATH"
fi

# Create a symbolic link to the new wallpaper
ln -sf "$WALLPAPER" "$ROFI_WALLPAPER_PATH"

# Function to convert hex color to rgba format
hex_to_rgba() {
    local hex="$1"
    local alpha="$2"
    printf "rgba(%d, %d, %d, %.1f)" 0x${hex:1:2} 0x${hex:3:2} 0x${hex:5:2} "$alpha"
}

# Extract colors from colors.json using jq
BACKGROUND=$(hex_to_rgba $(jq -r '.special.background' "$COLORS_FILE") 0.8)
FOREGROUND=$(hex_to_rgba $(jq -r '.special.foreground' "$COLORS_FILE") 1.0)
CURSOR=$(hex_to_rgba $(jq -r '.special.cursor' "$COLORS_FILE") 0.8)

COLOR0=$(hex_to_rgba $(jq -r '.colors.color0' "$COLORS_FILE") 0.8)
COLOR1=$(hex_to_rgba $(jq -r '.colors.color1' "$COLORS_FILE") 0.8)
COLOR2=$(hex_to_rgba $(jq -r '.colors.color2' "$COLORS_FILE") 0.8)
COLOR3=$(hex_to_rgba $(jq -r '.colors.color3' "$COLORS_FILE") 0.8)
COLOR4=$(hex_to_rgba $(jq -r '.colors.color4' "$COLORS_FILE") 0.8)
COLOR5=$(hex_to_rgba $(jq -r '.colors.color5' "$COLORS_FILE") 0.8)
COLOR6=$(hex_to_rgba $(jq -r '.colors.color6' "$COLORS_FILE") 0.8)
COLOR7=$(hex_to_rgba $(jq -r '.colors.color7' "$COLORS_FILE") 0.8)
COLOR8=$(hex_to_rgba $(jq -r '.colors.color8' "$COLORS_FILE") 0.8)
COLOR9=$(hex_to_rgba $(jq -r '.colors.color9' "$COLORS_FILE") 0.8)
COLOR10=$(hex_to_rgba $(jq -r '.colors.color10' "$COLORS_FILE") 0.8)
COLOR11=$(hex_to_rgba $(jq -r '.colors.color11' "$COLORS_FILE") 0.8)
COLOR12=$(hex_to_rgba $(jq -r '.colors.color12' "$COLORS_FILE") 0.8)
COLOR13=$(hex_to_rgba $(jq -r '.colors.color13' "$COLORS_FILE") 0.8)
COLOR14=$(hex_to_rgba $(jq -r '.colors.color14' "$COLORS_FILE") 0.8)
COLOR15=$(hex_to_rgba $(jq -r '.colors.color15' "$COLORS_FILE") 0.8) ).*' "$COLORS_FILE")
COLOR15=$(grep -oP '(?<=--color15: ).*' "$COLORS_FILE")

# Convert hex colors to rgba
BACKGROUND=$(hex_to_rgba $BACKGROUND 0.8)
FOREGROUND=$(hex_to_rgba $FOREGROUND 1.0)
CURSOR=$(hex_to_rgba $CURSOR 0.8)

COLOR0=$(hex_to_rgba $COLOR0 0.8)
COLOR1=$(hex_to_rgba $COLOR1 0.8)
COLOR2=$(hex_to_rgba $COLOR2 0.8)
COLOR3=$(hex_to_rgba $COLOR3 0.8)
COLOR4=$(hex_to_rgba $COLOR4 0.8)
COLOR5=$(hex_to_rgba $COLOR5 0.8)
COLOR6=$(hex_to_rgba $COLOR6 0.8)
COLOR7=$(hex_to_rgba $COLOR7 1.0)
COLOR8=$(hex_to_rgba $COLOR8 0.8)
COLOR9=$(hex_to_rgba $COLOR9 0.8)
COLOR10=$(hex_to_rgba $COLOR10 0.8)
COLOR11=$(hex_to_rgba $COLOR11 0.8)
COLOR12=$(hex_to_rgba $COLOR12 0.8)
COLOR13=$(hex_to_rgba $COLOR13 0.8)
COLOR14=$(hex_to_rgba $COLOR14 0.8)
COLOR15=$(hex_to_rgba $COLOR15 0.8)

# Create or update the rofi.rasi file with extracted colors
cat <<EOL > "$ROFI_FILE"

// Config //
configuration {
    modi:                        "drun,filebrowser,window";
    show-icons:                  true;
    display-drun:                " ";
    display-run:                 " ";
    display-filebrowser:         " ";
    display-window:              " ";
    drun-display-format:         "{name}";
    window-format:               "{w}{t}";
    font:                        "SF Pro Display Bold 10";
    icon-theme:                  "Tela-circle-dracula";
}

@theme "~/.config/rofi/theme.rasi"


// Main //
window {
    height:                      12em;
    width:                       38em;
    transparency:                "real";
    fullscreen:                  false;
    enabled:                     true;
    cursor:                      "default";
    spacing:                     0em;
    padding:                     0em;
    border-color:                @main-br;
    background-color:            $BACKGROUND;
}
mainbox {
    enabled:                     true;
    spacing:                     0em;
    padding:                     0em;
    orientation:                 vertical;
    children:                    [ "listbox" , "inputmode" ];
    background-color:            transparent;
}


// Lists //
listbox {
    padding:                     0em;
    spacing:                     0em;
    orientation:                 horizontal;
    children:                    [ "listview" ];
    background-color:            transparent;
       background-image:            url("$ROFI_WALLPAPER_PATH", width);
}
listview {
    padding:                     0.5em;
    spacing:                     0.2em;
    enabled:                     true;
    columns:                     5;
    cycle:                       true;
    dynamic:                     true;
    scrollbar:                   false;
    reverse:                     false;
    fixed-height:                true;
    fixed-columns:               true;
    cursor:                      "default";
    background-color:            $COLOR0;
    text-color:                  $COLOR7;
}


// Inputs //
inputmode {
    padding:                     0em;
    spacing:                     0em;
    orientation:                 horizontal;
    children:                    [ "inputbar" , "mode-switcher" ];
    background-color:            transparent;
}
inputbar {
    enabled:                     true;
    width:                       24em;
    padding:                     0em;
    spacing:                     0em;
    padding:                     1.5em 1em 1.5em 2.5em;
    children:                    [ "entry" ];
    background-color:            transparent;
}
entry {
    vertical-align:              0.5;
    border-radius:               3em;
    enabled:                     true;
    spacing:                     0em;
    padding:                     1em;
    text-color:                  $COLOR7;
    background-color:            $COLOR0;
}


// Modes //
mode-switcher {
    width:                       13em;
    orientation:                 horizontal;
    enabled:                     true;
    padding:                     1.5em 2.5em 1.5em 0em;
    spacing:                     1em;
    background-color:            transparent;
}
button {
    cursor:                      pointer;
    padding:                     0em;
    border-radius:               3em;
    background-color:            $COLOR0;
    text-color:                  $COLOR7;
}
button selected {
    background-color:            $COLOR6;
    text-color:                  $BACKGROUND;
}


// Elements //
element {
    orientation:                 vertical;
    enabled:                     true;
    spacing:                     0.2em;
    padding:                     0.5em;
    cursor:                      pointer;
    background-color:            transparent;
      text-color:                  $COLOR7;
}
element selected.normal {
    background-color:            $COLOR6;
    text-color:                  $BACKGROUND;
}
element-icon {
    size:                        2.5em;
    cursor:                      inherit;
    background-color:            transparent;
    text-color:                  inherit;
}
element-text {
    vertical-align:              0.5;
    horizontal-align:            0.5;
    cursor:                      inherit;
    background-color:            transparent;
    text-color:                  inherit;
}

