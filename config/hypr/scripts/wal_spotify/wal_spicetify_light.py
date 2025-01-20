import re

# Path to your Spicetify color.ini file
color_ini_path = ".config/spicetify/Themes//home/alien/Documents/GitHub/hyprclouds/hyprclouds/config/spicetify/Themes/material-colors-spotify/color.ini"

# Path to your CSS file
css_file_path = ".config/material-you/colors2.css"

# Function to extract color value from CSS
def extract_color(css_content, variable_name):
    match = re.search(rf'{variable_name}: (#\w+);', css_content)
    return match.group(1)[1:] if match else None  # Remove the '#' symbol

# Read CSS file content
with open(css_file_path, 'r') as css_file:
    css_content = css_file.read()

# Extract colors from the CSS file
colors = {
    "text": extract_color(css_content, '--dark-background'),
    "subtext": extract_color(css_content, '--light-on-primary-container'),
    "extratext": extract_color(css_content, '--light-inverse-surface'),
    "main": extract_color(css_content, '--light-surface-container-highest'),
    "main-elevated": extract_color(css_content, '--light-surface-container-highest'),  # Same as main
    "highlight-elevated": extract_color(css_content, '--light-on-primary-fixed-variant'),
    "highlight": extract_color(css_content, '--light-source-color'),
    "sidebar": extract_color(css_content, '--light-surface-container-highest'),  # Same as main
    "player": extract_color(css_content, '--light-surface-container-highest'),  # Same as main
    "sec-player": extract_color(css_content, '--light-surface-container-highest'),  # Same as main
    "card": extract_color(css_content, '--light-surface-container-highest'),  # Same as main
    "sec-card": extract_color(css_content, '--light-primary-container'),
    "shadow": extract_color(css_content, '--light-surface-container-highest'),  # Same as main
    "selected-row": extract_color(css_content, '--light-on-tertiary-fixed-variant'),
    "button": extract_color(css_content, '--light-primary-fixed-dim'),
    "button-active": extract_color(css_content, '--light-tertiary'),
    "button-disabled": extract_color(css_content, '--light-secondary-fixed-dim'),  # Same as main
    "tab-active": extract_color(css_content, '--light-secondary-fixed-dim'),
    "notification": extract_color(css_content, '--light-error'),
    "notification-error": extract_color(css_content, '--light-error'),
    "misc": extract_color(css_content, '--light-primary')
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
import subprocess

result = subprocess.run(["spicetify", "apply"], capture_output=True, text=True)

if result.returncode == 0:
    print("Spicetify applied successfully.")
else:
    print(f"Spicetify apply failed:\n{result.stderr}")
