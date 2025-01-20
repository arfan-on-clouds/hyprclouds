import re
import subprocess
import os

# Paths to your files
color_ini_path = ".config/spicetify/Themes//home/alien/Documents/GitHub/hyprclouds/hyprclouds/config/spicetify/Themes/material-colors-spotify/color.ini"
css_file_path = ".config/material-you/waybar-colors2.css"

# Function to extract color value from CSS
def extract_color(css_content, variable_name):
    # Improved regex pattern to match the variable name and color value
    match = re.search(rf'{variable_name} #([a-fA-F0-9]+);', css_content)
    return match.group(1) if match else None  # Return the color value without the '#'

# Read CSS file content
with open(css_file_path, 'r') as css_file:
    css_content = css_file.read()

# Extract colors from the CSS file
colors = {
    "text": extract_color(css_content, '@define-color dark-secondary'),
    "subtext": extract_color(css_content, '@define-color dark-secondary'),
    "extratext": extract_color(css_content, '@define-color dark-secondary'),
    "main": extract_color(css_content, '@define-color dark-background'),
    "main-elevated": extract_color(css_content, '@define-color dark-background'),  # Same as main
    "highlight-elevated": extract_color(css_content, '@define-color dark-primary'),
    "highlight": extract_color(css_content, '@define-color dark-surface'),
    "sidebar": extract_color(css_content, '@define-color dark-background'),  # Same as main
    "player": extract_color(css_content, '@define-color light-on-background'),  # Same as main
    "sec-player": extract_color(css_content, '@define-color dark-surface'),  # Same as main
    "card": extract_color(css_content, '@define-color light-on-background'),  # Same as main
    "sec-card": extract_color(css_content, '@define-color light-secondary'),
    "shadow": extract_color(css_content, '@define-color dark-background'),  # Same as main
    "selected-row": extract_color(css_content, '@define-color dark-primary'),
    "button": extract_color(css_content, '@define-color dark-on-primary'),
    "button-active": extract_color(css_content, '@define-color dark-primary'),
    "button-disabled": extract_color(css_content, '@define-color dark-background'),  # Same as main
    "tab-active": extract_color(css_content, '@define-color light-secondary'),
    "notification": extract_color(css_content, '@define-color light-secondary'),
    "notification-error": extract_color(css_content, '@define-color dark-error'),
    "misc": extract_color(css_content, '@define-color dark-error')
}

# Check if all colors are extracted correctly
missing_colors = [key for key, value in colors.items() if value is None]
if missing_colors:
    print(f"Error: Missing colors in CSS file: {', '.join(missing_colors)}")
    exit(1)

# Update color.ini file
with open(color_ini_path, 'w') as color_ini_file:
    color_ini_file.write("[Colors]\n")
    for key, value in colors.items():
        color_ini_file.write(f"{key} = {value}\n")

# Run Spicetify to apply the changes
result = subprocess.run(["spicetify", "apply"], capture_output=True, text=True)

if result.returncode == 0:
    print("Spicetify applied successfully.")
else:
    print(f"Spicetify apply failed:\n{result.stderr}")
