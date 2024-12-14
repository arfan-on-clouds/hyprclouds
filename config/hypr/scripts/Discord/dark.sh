#!/bin/bash

# Define file paths
COLORS_FILE="$HOME/.cache/material-you/colors.css"
THEME_FILE="$HOME/.var/app/dev.vencord.Vesktop/config/vesktop/themes/material-vencord.css"

# Check if the colors file exists
if [[ ! -f "$COLORS_FILE" ]]; then
    echo "Colors file not found: $COLORS_FILE"
    exit 1
fi

# Read colors from the file
background=$(grep -- '--background' "$COLORS_FILE" | awk -F': ' '{print $2}' | tr -d ';')
color2=$(grep -- '--color2' "$COLORS_FILE" | awk -F': ' '{print $2}' | tr -d ';')
color3=$(grep -- '--color3' "$COLORS_FILE" | awk -F': ' '{print $2}' | tr -d ';')
color4=$(grep -- '--color4' "$COLORS_FILE" | awk -F': ' '{print $2}' | tr -d ';')
color5=$(grep -- '--color5' "$COLORS_FILE" | awk -F': ' '{print $2}' | tr -d ';')
color6=$(grep -- '--color6' "$COLORS_FILE" | awk -F': ' '{print $2}' | tr -d ';')
color7=$(grep -- '--color7' "$COLORS_FILE" | awk -F': ' '{print $2}' | tr -d ';')

# Check if all colors are found
if [[ -z "$background" || -z "$color2" || -z "$color3" || -z "$color4" || -z "$color5" || -z "$color6" || -z "$color7" ]]; then
    echo "Failed to extract all required colors from $COLORS_FILE"
    exit 1
fi

# Create the theme file content
cat <<EOL > "$THEME_FILE"

* {
    /* font-family: "JetBrains Mono"; */
    /* font-style: italic; */

    /* *.background */
    --background-primary: $background;
    --background-secondary: $background;
    --background-tertiary: $background;

    --background-primary-alt: $background;
    --background-secondary-alt: $background;
    --background-tertiary-alt: $background;

    --channeltextarea-background: $background;
    --custom-channel-members-bg: $background;

    --profile-gradient-primary-color: $background;
    --profile-gradient-secondary-color: $background;
    --profile-body-background-color: $background;

    --__header-bar-background: $background !important;

    --scrollbar-auto-track: $background;
    --scrollbar-thin-track: $background;

    /* primary.* */
    --primary-630: $background;
    
    /* *.color2 */
    --scrollbar-auto-thumb: $color2;
    --scrollbar-thin-thumb: $color2;

    /* *.color3 */
    --red-400: $color3;

    /* *.color4 */
    --status-danger: $color4;
    --button-outline-danger-border: $color4;
    --button-outline-danger-text: $color4;
    --button-danger-background: $color4;

    --yellow-300: $color4;

    /* *.color5 */
    --header-primary: $color5;
    --brand-experiment: $color5;
    --brand-experiment-360: $color5;
    --brand-experiment-500: $color5;
    --profile-gradient-button-color: $color5;

    --green-360: $color5;

    /* *.color6 */
    --channels-default: $color6;
    --channel-icon: $color6;

    /* *.color7 */
    --text-normal: $color7;
    --interactive-active: $color7;
}

/* status indicators */
rect[fill="#f23f43"] {
    fill: $color3 !important;
}

rect[fill="#f0b232"] {
    fill: $color4 !important;
}

rect[fill="#23a55a"] {
    fill: $color5 !important;
}
EOL

echo "Vencord theme file created successfully at $THEME_FILE"
