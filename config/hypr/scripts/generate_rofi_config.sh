#!/bin/bash

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

# Extract colors from colors.json using jq
BACKGROUND=$(jq -r '.special.background' "$COLORS_FILE")
FOREGROUND=$(jq -r '.special.foreground' "$COLORS_FILE")
CURSOR=$(jq -r '.special.cursor' "$COLORS_FILE")

COLOR0=$(jq -r '.colors.color0' "$COLORS_FILE")
COLOR1=$(jq -r '.colors.color1' "$COLORS_FILE")
COLOR2=$(jq -r '.colors.color2' "$COLORS_FILE")
COLOR3=$(jq -r '.colors.color3' "$COLORS_FILE")
COLOR4=$(jq -r '.colors.color4' "$COLORS_FILE")
COLOR5=$(jq -r '.colors.color5' "$COLORS_FILE")
COLOR6=$(jq -r '.colors.color6' "$COLORS_FILE")
COLOR7=$(jq -r '.colors.color7' "$COLORS_FILE")
COLOR8=$(jq -r '.colors.color8' "$COLORS_FILE")
COLOR9=$(jq -r '.colors.color9' "$COLORS_FILE")
COLOR10=$(jq -r '.colors.color10' "$COLORS_FILE")
COLOR11=$(jq -r '.colors.color11' "$COLORS_FILE")
COLOR12=$(jq -r '.colors.color12' "$COLORS_FILE")
COLOR13=$(jq -r '.colors.color13' "$COLORS_FILE")
COLOR14=$(jq -r '.colors.color14' "$COLORS_FILE")
COLOR15=$(jq -r '.colors.color15' "$COLORS_FILE")

# Create or update the rofi.rasi file with extracted colors
cat <<EOL > "$ROFI_FILE"
/*****----- Configuration -----*****/
configuration {
    modi:                       "drun,run,filebrowser,window";
    show-icons:                 true;
    display-drun:                "";
    display-run:                 " ";
    display-filebrowser:         " ";
    display-window:              " ";
    drun-display-format:         "{name}";
    window-format:               "{w}{t}";
    font:                        "JetBrainsMono Nerd Font 10";
    icon-theme:                  "Rose-Pine";
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
    border-radius:               20px;
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
    background-color:            $BACKGROUND;
    text-color:                  $FOREGROUND;
    children:                    [ "textbox-prompt-colon", "entry" ];
}
textbox-prompt-colon {
    enabled:                     true;
    expand:                      false;
    str:                         "";
    background-color:            inherit;
    text-color:                  inherit;
}
entry {
    enabled:                     true;
    background-color:            inherit;
    text-color:                  inherit;
    cursor:                      text;
    placeholder:                 "Search";
    placeholder-color:           inherit;
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
    background-color:            $COLOR2;
    text-color:                  $FOREGROUND;
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
    background-color:            $COLOR2;
    text-color:                  $FOREGROUND;
}
element normal.active {
    background-color:            $COLOR2;
    text-color:                  $FOREGROUND;
}
element selected.normal {
    background-color:            $COLOR2;
    text-color:                  $FOREGROUND;
}
element selected.urgent {
    background-color:            $COLOR2;
    text-color:                  $FOREGROUND;
}
element selected.active {
    background-color:            $COLOR2;
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
    background-color:            $COLOR2;
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
