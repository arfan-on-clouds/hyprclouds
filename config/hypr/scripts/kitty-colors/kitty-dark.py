import os
import re

# Define source and target files
source_file = os.path.expanduser("~/.cache/material-you/colors.css")  # Update this path if needed
target_file = os.path.expanduser("~/.config/kitty/dark/kitty.conf")  # Update this path if needed

# Ensure the source file exists
if not os.path.isfile(source_file):
    print(f"Source file not found: {source_file}")
    exit(1)

# Function to extract color value
def extract_color(file_content, color_name):
    match = re.search(f'{color_name}: (#[0-9a-fA-F]{{6}})', file_content)
    return match.group(1) if match else "#000000"

# Read the source file content
with open(source_file, 'r') as file:
    content = file.read()

# Extracting the colors from the source file
background = extract_color(content, '--background')
foreground = extract_color(content, '--foreground')
cursor = extract_color(content, '--cursor')

# Extract color0 to color15
colors = [extract_color(content, f'--color{i}') for i in range(16)]

# Map the extracted colors to the desired output colors for Kitty
new_colors = {
    'foreground': foreground,  # Desired foreground color
    'background': background,  # Desired background color
    'cursor': cursor,          # Desired cursor color
    'color0': colors[7],       # Custom color0
    'color1': colors[1],       # Custom color1
    'color2': colors[2],       # Custom color2
    'color3': colors[3],       # Custom color3
    'color4': colors[4],       # Custom color4
    'color5': colors[5],       # Custom color5
    'color6': colors[6],       # Custom color6
    'color7': colors[7],       # Custom color7
    'color8': colors[8],       # Custom color8
    'color9': colors[9],       # Custom color9
    'color10': colors[10],     # Custom color10
    'color11': colors[11],     # Custom color11
    'color12': colors[12],     # Custom color12
    'color13': colors[13],     # Custom color13
    'color14': colors[14],     # Custom color14
    'color15': colors[15],     # Custom color15
}

# Create the target directory if it doesn't exist
os.makedirs(os.path.dirname(target_file), exist_ok=True)

# Write the colors to the target file
with open(target_file, 'w') as file:
    file.write(f'foreground {new_colors["foreground"]}\n')
    file.write(f'background {new_colors["background"]}\n')
    file.write(f'cursor {new_colors["cursor"]}\n\n')
    
    for i in range(16):
        file.write(f'color{i} {new_colors[f"color{i}"]}\n')  # Write all colors

print(f"Colors have been exported to: {target_file}")
