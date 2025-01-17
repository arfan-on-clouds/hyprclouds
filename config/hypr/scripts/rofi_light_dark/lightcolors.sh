#!/bin/bash

# Path to the input colors.css file
colors_css="$HOME/.config/material-you/waybar-colors.css"

# Path to the output CSS file
output_css="$HOME/.config/rofi/powermenu/type-2/lightcolors.rasi"

# Check if the colors.css file exists
if [[ ! -f $colors_css ]]; then
    echo "colors.css not found. Make sure the file exists."
    exit 1
fi

# Function to extract color value from colors.css
extract_color() {
    local color_name=$1
    local color_value
    # Extract the color value using a more specific regular expression
    color_value=$(grep -Po "(?<=@define-color ${color_name} )#[0-9a-fA-F]{6}" "$colors_css")
    if [[ -z $color_value ]]; then
        echo "Error: Could not find color value for ${color_name} in $colors_css"
        return 1
    fi
    echo $color_value
}

# Extract colors from colors.css
background=$(extract_color "dark-onBackground") || exit 1
background_alt=$(extract_color "dark-secondary") || exit 1
foreground=$(extract_color "dark-background") || exit 1
selected=$(extract_color "light-primary") || exit 1
active=$(extract_color "light-error") || exit 1
urgent=$(extract_color "dark-error") || exit 1

# Generate the CSS file with the extracted colors
cat <<EOF > "$output_css"
/**
 *
 * Author : Your Name
 * Github : @your_github_handle
 * 
 * Colors
 **/

* {
    background:     ${background};
    background-alt: ${background_alt};
    foreground:     ${foreground};
    selected:       ${selected};
    active:         ${active};
    urgent:         ${urgent};
}
EOF

echo "CSS file generated successfully at $output_css."
