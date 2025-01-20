#!/bin/bash

# Change system wallpaper
WALLPAPER="$1"
# Add your logic here to set the wallpaper

# Update Rofi configuration with the new wallpaper
ROFI_WALLPAPER_PATH="${HOME}/.config/rofi/launchers/type-6/current-wallpaper.png"
COLORS_FILE="$HOME/.config/material-you/colors2.css"
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
extract_color() {
    local color_name="$1"
    grep -oP "(?<=--$color_name: ).*" "$COLORS_FILE"
}

BACKGROUND=$(extract_color "light-surface-container-highest")
FOREGROUND=$(extract_color "light-on-background")
CURSOR=$(extract_color "dark-primary")

COLOR0=$(extract_color "light-surface-container-highest")
COLOR1=$(extract_color "dark-secondary")
COLOR2=$(extract_color "dark-tertiary")
COLOR3=$(extract_color "dark-outline")
COLOR4=$(extract_color "dark-error")
COLOR5=$(extract_color "dark-on-error")
COLOR6=$(extract_color "dark-on-background")
COLOR7=$(extract_color "light-primary")
COLOR8=$(extract_color "light-primary")
COLOR9=$(extract_color "dark-secondary")
COLOR10=$(extract_color "dark-tertiary")
COLOR11=$(extract_color "dark-outline")
COLOR12=$(extract_color "dark-error")
COLOR13=$(extract_color "dark-on-error")
COLOR14=$(extract_color "light-primary")
COLOR15=$(extract_color "dark-on-surface")

# Convert hex colors to rgba
BACKGROUND=$(hex_to_rgba $BACKGROUND 1.0)
FOREGROUND=$(hex_to_rgba $FOREGROUND 1.0)
CURSOR=$(hex_to_rgba $CURSOR 0.8)

COLOR0=$(hex_to_rgba $COLOR0 0.8)
COLOR1=$(hex_to_rgba $COLOR1 1.0)
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
COLOR14=$(hex_to_rgba $COLOR14 1.0)
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
    border-radius:               15px;
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
    background-color:            transparent;
    background-image:            url("$ROFI_WALLPAPER_PATH", height);
    orientation:                 vertical;
    children:                    [ "inputbar", "dummy", "mode-switcher" ];
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
    background-color:            transparent;
    text-color:                  $FOREGROUND;
    children:                    [ "textbox-prompt-colon", "entry" ];
}
textbox-prompt-colon {
    enabled:                     true;
    expand:                      false;
    str:                         "";
    background-color:            inherit;
    text-color:                  $BACKGROUND;
}
entry {
    enabled:                     true;
    background-color:            inherit;
    text-color:                  inherit;
    cursor:                      text;
    placeholder:                 "Search";
    placeholder-color:            $BACKGROUND;
}

/*****----- Mode Switcher -----*****/
mode-switcher {
    enabled:                     true;
    spacing:                     20px;
    background-color:            transparent;
    text-color:                $BACKGROUND;
}
button {
   padding:                     17px;
    border-radius:               30px;
    background-color:            $BACKGROUND;
    text-color:                  $FOREGROUND;
    cursor:                      pointer;
}
button selected {
    background-color:            $COLOR14;
    text-color:                 $BACKGROUND;
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
    text-color:                   $FOREGROUND;
    cursor:                      pointer;
}
element normal.normal {
    background-color:            inherit;
    text-color:                  inherit;
}
element normal.urgent {
    background-color:            $COLOR14;
    text-color:                   $BACKGROUND;
}
element normal.active {
    background-color:            $COLOR14;
    text-color:                  $BACKGROUND;
}
element selected.normal {
    background-color:            $COLOR14;
    text-color:                 $BACKGROUND;
}
element selected.urgent {
    background-color:            $COLOR14;
    text-color:                  $BACKGROUND;
}
element selected.active {
    background-color:            $COLOR14;
    text-color:                 $BACKGROUND;
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
    background-color:            $COLOR14;
    text-color:                 $BACKGROUND;
    vertical-align:              0.5;
    horizontal-align:            0.0;
}
error-message {
    padding:                     15px;
    border-radius:               20px;
    background-color:            $FOREGROUND;
    text-color:                  $BACKGROUND;
}
EOL

echo "Rofi configuration file updated at $ROFI_FILE"
