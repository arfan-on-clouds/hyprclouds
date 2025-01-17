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
COLOR14=$(grep -oP '(?<=--color14: ).*' "$COLORS_FILE")
COLOR15=$(grep -oP '(?<=--color15: ).*' "$COLORS_FILE")

# Convert hex colors to rgba
BACKGROUND=$(hex_to_rgba $BACKGROUND 0.2)
FOREGROUND=$(hex_to_rgba $FOREGROUND 1.0)
CURSOR=$(hex_to_rgba $CURSOR 0.8)

COLOR0=$(hex_to_rgba $COLOR0 0.8)
COLOR1=$(hex_to_rgba $COLOR1 0.8)
COLOR2=$(hex_to_rgba $COLOR2 0.8)
COLOR3=$(hex_to_rgba $COLOR3 0.8)
COLOR4=$(hex_to_rgba $COLOR4 0.2)
COLOR5=$(hex_to_rgba $COLOR5 0.8)
COLOR6=$(hex_to_rgba $COLOR6 0.8)
COLOR7=$(hex_to_rgba $COLOR7 1.0)
COLOR8=$(hex_to_rgba $COLOR8 0.8)
COLOR9=$(hex_to_rgba $COLOR9 0.8)
COLOR10=$(hex_to_rgba $COLOR10 0.8)
COLOR11=$(hex_to_rgba $COLOR11 0.8)
COLOR12=$(hex_to_rgba $COLOR12 0.8)
COLOR13=$(hex_to_rgba $COLOR13 0.8)
COLOR14=$(hex_to_rgba $COLOR14 1.0)
COLOR15=$(hex_to_rgba $COLOR15 0.8)

# Create or update the rofi.rasi file with extracted colors
cat <<EOL > "$ROFI_FILE"
/*****----- Configuration -----*****/
configuration {
    modi:                        "drun,filebrowser,window,run";
    show-icons:                  true;
    display-drun:                " ";
    display-run:                 " ";
    display-filebrowser:         " ";
    display-window:              " ";
    drun-display-format:         "{name}";
    window-format:               "{w}{t}";
    font:                        "SF Pro Display Bold 10";
    icon-theme:                  "Tela-circle-dracula";
}

@theme "~/.config/rofi/theme.rasi"

/*****----- Main Window -----*****/
window {
    height:                      30em;
    width:                       25em;
    transparency:                "real";
    fullscreen:                  false;
    enabled:                     true;
    cursor:                      "default";
    spacing:                     0em;
    padding:                     0em;
    border-color:                $COLOR4;
    background-color:            $BACKGROUND;
}

/*****----- Main Box -----*****/
mainbox {
    enabled:                     true;
    spacing:                     0em;
    padding:                     1em;
    orientation:                 vertical;
    children:                    [ "inputbar" , "listbox" ];
    background-color:            transparent;
}

/*****----- Inputbar -----*****/
inputbar {
    enabled:                     true;
    spacing:                     0em;
    padding:                     4em;
    children:                    [ "entry" ];
    background-color:            $BACKGROUND;
    background-image:            url("$ROFI_WALLPAPER_PATH", width);
    border-radius:               1em 1em 0em 0em;
}
entry {
    enabled:                     false;
}

/*****----- Lists -----*****/
listbox {
    spacing:                     0em;
    padding:                     0em;
    children:                    [ "dummyt" , "listview" , "dummyb" ];
    background-color:            $COLOR0;
    border-radius:               0em 0em 1em 1em;
}
listview {
    enabled:                     true;
    spacing:                     0.4em;
    padding:                     1em;
    columns:                     1;
    lines:                       7;
    cycle:                       true;
    dynamic:                     true;
    scrollbar:                   false;
    layout:                      vertical;
    reverse:                     false;
    expand:                      false;
    fixed-height:                true;
    fixed-columns:               true;
    cursor:                      "default";
    background-color:            $BACKGROUND;
    text-color:                  $FOREGROUND;
}
dummyt {
    spacing:                     0em;
    padding:                     0em;
    background-color:            $BACKGROUND;
}
dummyb {
    spacing:                     0em;
    padding:                     0em;
    background-color:            $BACKGROUND;
    border-radius:               0em 0em 1em 1em;
}

/*****----- Elements -----*****/
element {
    enabled:                     true;
    spacing:                     1em;
    padding:                     0.2em 0.2em 0.2em 1.5em;
    cursor:                      pointer;
    background-color:            transparent;
    text-color:                  $FOREGROUND;
}
element selected.normal {
    background-color:            $COLOR14;
    text-color:                  $COLOR0;
}
element-icon {
    size:                        2em;
    cursor:                      inherit;
    background-color:            transparent;
    text-color:                  inherit;
}
element-text {
    vertical-align:              0.5;
    horizontal-align:            0.0;
    cursor:                      inherit;
    background-color:            transparent;
    text-color:                  inherit;
}
EOL

echo "Rofi configuration file updated at $ROFI_FILE"
