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
/*****----- Configuration -----*****/
configuration {
    modi:                       "drun,run,filebrowser,window";
    show-icons:                 true;
    display-drun:                " ";
    display-run:                 " ";
    display-filebrowser:         " ";
    display-window:              " ";
    drun-display-format:         "{name}";
    window-format:               "{w}{t}";
    font:                        "SF Pro Display Bold 10";
    icon-theme:                  "Tela-circle-black-dark";
}

/*****----- Main Window -----*****/
window {
    height:                      300px;
    width:                       650px;
    transparency:                "real";
    location:                    center;
    anchor:                      center;
    fullscreen:                  false;
    x-offset:                    0px;
    y-offset:                    0px;
    enabled:                     true; 
    border:                      0px solid;
    border-radius:               10px;
    border-color:                $COLOR3;
    cursor:                      "default";
    background-color:            $BACKGROUND;
}

/*****----- Main Box -----*****/
mainbox {
    enabled:                     true;
    spacing:                     12px;
    background-color:            transparent;
    orientation:                 horizontal;
    children:                    [ "imagebox", "listbox" ];
}

imagebox {
    padding:                     20px;
    margin:                      20px;
    border-radius:                12px;
    background-color:            transparent;
    background-image:            url("$ROFI_WALLPAPER_PATH", height);
    orientation:                 vertical;
    children:                    [ "inputbar"];
}

listbox {
    spacing:                     5px;
    padding:                     20px;
    background-color:            transparent;
    orientation:                 vertical;
    children:                    [ "message", "listview" ];
}

dummy {
    background-color:            transparent;
}

/*****----- Inputbar -----*****/
inputbar {
    enabled:                     true;
    spacing:                     10px;
    padding:                     10px;
    border-radius:               15px;
     margin:                      0px;
     border-radius:               10px;
    background-color:            transparent;
    text-color:                  $FOREGROUND;
    children:                    [ "textbox-prompt-colon", "entry" ];
}
textbox-prompt-colon {
    enabled:                     true;
    expand:                      false;
    str:                         "";
    background-color:            inherit;
    text-color:                  inherit;
}
entry {
    enabled:                     true;
    background-color:            inherit;
    text-color:                  $COLOR7;
    cursor:                      text;
    placeholder:                 "Search";
    placeholder-color:           $COLOR7;
}

/*****----- Mode Switcher -----*****/
mode-switcher {
    enabled:                     true;
    spacing:                     20px;
    background-color:            transparent;
    text-color:                  $FOREGROUND;
}
button {
   padding:                     17px;
    border-radius:               30px;
    background-color:            $BACKGROUND;
    text-color:                  inherit;
    cursor:                      pointer;
}
button selected {
    background-color:            $COLOR14;
    text-color:                  $BACKGROUND;
    padding:                     15px;
    border-radius:               30px;
}

/*****----- Listview -----*****/
listview {
    enabled:                     true;
    columns:                     1;
    lines:                       11;
    cycle:                       true;
    dynamic:                     true;
    scrollbar:                   false;
    layout:                      vertical;
    reverse:                     false;
    fixed-height:                true;
    fixed-columns:               true;
     spacing:                     5px;
    background-color:            transparent;
    text-color:                  $FOREGROUND;
    cursor:                      "default";
}

/*****----- Elements -----*****/
element {
    enabled:                     true;
    spacing:                     15px;
    padding:                     8px;
    border-radius:               15px;
    background-color:            transparent;
    text-color:                  $FOREGROUND;
    cursor:                      pointer;
}
element normal.normal {
    background-color:            inherit;
    text-color:                  inherit;
}
element normal.urgent {
    background-color:            $COLOR1;
    text-color:                  $FOREGROUND;
}
element normal.active {
    background-color:            $COLOR1;
    text-color:                  $FOREGROUND;
}
element selected.normal {
    background-color:            $COLOR14;
    text-color:                  $BACKGROUND;
}
element selected.urgent {
    background-color:            $COLOR1;
    text-color:                  $FOREGROUND;
}
element selected.active {
    background-color:            $COLOR1;
    text-color:                  $FOREGROUND;
}
element-icon {
    background-color:            transparent;
    text-color:                  inherit;
    size:                        32px;
    cursor:                      inherit;
}
element-text {
    background-color:            transparent;
    text-color:                  inherit;
    cursor:                      inherit;
    vertical-align:              0.5;
    horizontal-align:            0.0;
}

/*****----- Message -----*****/
message {
    background-color:            transparent;
}
textbox {
    padding:                     15px;
    border-radius:               10px;
    background-color:            $COLOR1;
    text-color:                  $FOREGROUND;
    vertical-align:              0.5;
    horizontal-align:            0.0;
}
error-message {
    padding:                     15px;
    border-radius:               20px;
    background-color:            $BACKGROUND;
    text-color:                  $FOREGROUND;
}
EOL

echo "Rofi configuration file updated at $ROFI_FILE"
