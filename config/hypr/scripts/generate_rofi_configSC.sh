#!/bin/bash

# Path to the colors.json file
COLORS_FILE="$HOME/.cache/wal/colors.json"
# Path to the Rofi configuration file
ROFI_FILE="/home/alien/.config/rofi/applets/type-2/style-3.rasi"

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
    show-icons:                 false;
}

/*****----- Global Properties -----*****/
@import                          "../shared/colors.rasi"
@import                          "../shared/fonts.rasi"

/*
USE_ICON=YES
*/

/*****----- Main Window -----*****/
window {
    transparency:                "real";
    location:                    center;
    anchor:                      center;
    fullscreen:                  false;
    width:                       800px;
    x-offset:                    0px;
    y-offset:                    0px;
    margin:                      0px;
    padding:                     0px;
    border:                      0px solid;
    border-radius:               20px;
    border-color:                $COLOR3;
    cursor:                      "default";
    background-color:            $BACKGROUND;
}

/*****----- Main Box -----*****/
mainbox {
    enabled:                     true;
    spacing:                     15px;
    margin:                      0px;
    padding:                     30px;
    background-color:            transparent;
    children:                    [ "inputbar", "message", "listview" ];
}

/*****----- Inputbar -----*****/
inputbar {
    enabled:                     true;
    spacing:                     10px;
    padding:                     0px;
    border:                      0px;
    border-radius:               100%;
    border-color:                $COLOR3;
    background-color:            transparent;
    text-color:                  $FOREGROUND;
    children:                    [ "textbox-prompt-colon", "prompt"];
}

textbox-prompt-colon {
    enabled:                     true;
    expand:                      false;
    str:                         "";
    padding:                     10px 13px;
    border-radius:               100%;
    background-color:            $COLOR1;
    text-color:                  $BACKGROUND;
}
prompt {
    enabled:                     true;
    padding:                     10px;
    border-radius:               100%;
    background-color:            $COLOR2;
    text-color:                  $BACKGROUND;
}

/*****----- Message -----*****/
message {
    enabled:                     true;
    margin:                      0px;
    padding:                     10px;
    border:                      0px solid;
    border-radius:               100%;
    border-color:                $COLOR3;
    background-color:            $COLOR4;
    text-color:                  $FOREGROUND;
}
textbox {
    background-color:            inherit;
    text-color:                  inherit;
    vertical-align:              0.5;
    horizontal-align:            0.0;
}

/*****----- Listview -----*****/
listview {
    enabled:                     true;
    columns:                     6;
    lines:                       1;
    cycle:                       true;
    scrollbar:                   false;
    layout:                      vertical;
    
    spacing:                     15px;
    background-color:            transparent;
    cursor:                      "default";
}

/*****----- Elements -----*****/
element {
    enabled:                     true;
    padding:                     30px 10px;
    border:                      0px solid;
    border-radius:               100%;
    border-color:                $COLOR3;
    background-color:            transparent;
    text-color:                  $FOREGROUND;
    cursor:                      pointer;
}
element-text {
    font:                        "feather 28";
    background-color:            transparent;
    text-color:                  inherit;
    cursor:                      inherit;
    vertical-align:              0.5;
    horizontal-align:            0.5;
}

element normal.normal,
element alternate.normal {
    background-color:            $COLOR5;
    text-color:                  $FOREGROUND;
}
element normal.urgent,
element alternate.urgent,
element selected.active {
    background-color:            $COLOR6;
    text-color:                  $BACKGROUND;
}
element normal.active,
element alternate.active,
element selected.urgent {
    background-color:            $COLOR7;
    text-color:                  $BACKGROUND;
}
element selected.normal {
    background-color:            $COLOR8;
    text-color:                  $BACKGROUND;
}
EOL

echo "Rofi configuration file updated at $ROFI_FILE"
