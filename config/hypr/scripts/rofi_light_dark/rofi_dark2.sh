#!/bin/bash

# Change system wallpaper
# Assuming your original script logic for changing the wallpaper is here
WALLPAPER="$1"
# Add your logic here to set the wallpaper

# Update Rofi configuration with the new wallpaper
ROFI_WALLPAPER_PATH="${HOME}/.config/rofi/launchers/type-6/current-wallpaper.png"
COLORS_FILE="$HOME/.cache/material-you/colors.css"
ROFI_FILE="${HOME}/.config/rofi/launchers/type-6/style-9.rasi"

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

COLOR0=$(hex_to_rgba $BACKGROUND 0.8)
COLOR1=$(hex_to_rgba $BACKGROUND 0.8)
COLOR2=$(hex_to_rgba $BACKGROUND 0.8)
COLOR3=$(hex_to_rgba $COLOR3 0.8)
COLOR4=$(hex_to_rgba $COLOR4 0.8)
COLOR5=$(hex_to_rgba $COLOR5 0.8)
COLOR6=$(hex_to_rgba $COLOR6 0.8)
COLOR7=$(hex_to_rgba $color7 1.0)
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
configuration {
	modi:                       "drun,filebrowser,window";
    show-icons:                 true;
    display-drun:               "";
    display-run:                "";
    display-filebrowser:        "";
    display-window:             "";
	drun-display-format:        "{name}";
	window-format:              "{w} · {c} · {t}";
}

/*****----- Global Properties -----*****/
* {
    font:                        "SF Pro Display Bold 10";
    background:                  $BACKGROUND;
    background-alt:              $COLOR4;
    foreground:                  $FOREGROUND;
    selected:                    $COLOR14;
    active:                      #2E3F34;
    urgent:                      #D08261;
}

/*****----- Main Window -----*****/
window {
    /* properties for window widget */
    transparency:                "real";
    location:                    center;
    anchor:                      center;
    fullscreen:                  false;
    width:                       420px;
    height:                      530px;
    x-offset:                    0px;
    y-offset:                    0px;

    /* properties for all widgets */
    enabled:                     true;
    border-radius:               0px;
    cursor:                      "default";
    background-color:            @background;
}

/*****----- Main Box -----*****/
mainbox {
    enabled:                     true;
    spacing:                     0px;
    background-color:            transparent;
    orientation:                 vertical;
    children:                    [ "inputbar", "listbox" ];
}

listbox {
    spacing:                     20px;
    padding:                     20px;
    background-color:            transparent;
    orientation:                 vertical;
    children:                    [ "message", "listview" ];
}

/*****----- Inputbar -----*****/
inputbar {
    enabled:                     true;
    spacing:                     10px;
    padding:                     80px 60px;
    margin:                      20px;
    border-radius:               12px;
    background-color:            transparent;
        background-image:            url("$ROFI_WALLPAPER_PATH", width);
    text-color:                  @foreground;
    orientation:                 horizontal;
    children:                    [ "textbox-prompt-colon", "entry" ];
}
textbox-prompt-colon {
    enabled:                     true;
    expand:                      false;
    str:                         "";
    padding:                     12px 15px;
    border-radius:               100%;
    background-color:            transparent;
    text-color:                  inherit;
}
entry {
    enabled:                     true;
    expand:                      false;
    width:                       250px;
    padding:                     12px 16px;
    border-radius:               100%;
    background-color:            transparent;
    text-color:                  $FOREGROUND;
    cursor:                      text;
    placeholder:                 "Search";
    placeholder-color:           inherit;
}
dummy {
    expand:                      true;
    background-color:            transparent;
}

/*****----- Mode Switcher -----*****/
mode-switcher{
    enabled:                     true;
    spacing:                     10px;
    background-color:            transparent;
    text-color:                  @foreground;
}
button {
    width:                       45px;
    padding:                     12px;
    border-radius:               100%;
    background-color:            @background-alt;
    text-color:                  inherit;
    cursor:                      pointer;
}
button selected {
    background-color:            @selected;
    text-color:                  $BACKGROUND;
}

/*****----- Listview -----*****/
listview {
    enabled:                     true;
    columns:                     1;
    lines:                       7;
    cycle:                       true;
    dynamic:                     true;
    scrollbar:                   false;
    layout:                      vertical;
    reverse:                     false;
    fixed-height:                true;
    fixed-columns:               true;
    
    spacing:                     10px;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      "default";
}

/*****----- Elements -----*****/
element {
    enabled:                     true;
    spacing:                     10px;
    padding:                     4px;
    border-radius:               100%;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      pointer;
}
element normal.normal {
    background-color:            inherit;
    text-color:                  inherit;
}
element normal.urgent {
    background-color:            @urgent;
    text-color:                  @foreground;
}
element normal.active {
    background-color:            @active;
    text-color:                  @foreground;
}
element selected.normal {
    background-color:            @selected;
    text-color:                  @background;
}
element selected.urgent {
    background-color:            @urgent;
    text-color:                  @foreground;
}
element selected.active {
    background-color:            @urgent;
    text-color:                  @foreground;
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
    padding:                     12px;
    border-radius:               100%;
    background-color:            @background-alt;
    text-color:                  @foreground;
    vertical-align:              0.5;
    horizontal-align:            0.0;
}
error-message {
    padding:                     12px;
    border-radius:               20px;
    background-color:            @background;
    text-color:                  @foreground;
}
