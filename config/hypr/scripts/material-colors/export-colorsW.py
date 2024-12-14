import os
import re

# Define source and target files
source_file = os.path.expanduser("~/.cache/material-you/colors.css")
target_files = [
    os.path.expanduser("~/.themes/Material-wally/gtk-3.0/colors.css"),
    os.path.expanduser("/home/alien/.config/gtk-4.0/colors.css")
]

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

# Map the extracted colors to the desired output colors
new_colors = {
    'foreground': background,  # Desired foreground color
    'background': foreground,  # Desired background color
    'cursor': colors[0],      # Desired cursor color
    'color0': colors[7],      # Using color7 for color0
    'color1': colors[6],      # Custom color for color1
    'color2': colors[5],      # Custom color for color2
    'color3': colors[4],      # Custom color for color3
    'color4': colors[3],      # Keep original color4
    'color5': colors[2],      # Keep original color5
    'color6': colors[1],      # Keep original color6
    'color7': colors[0],      # Using color0 for color7
    'color8': colors[15],     # Custom color for color8
    'color9': colors[14],     # Keep original color9
    'color10': colors[13],    # Keep original color10
    'color11': colors[12],    # Keep original color11
    'color12': colors[11],    # Keep original color12
    'color13': colors[10],    # Keep original color13
    'color14': colors[9],     # Keep original color14
    'color15': colors[8],     # Keep original color15
}

# Write the colors to each target file
for target_file in target_files:
    # Create the target directory if it doesn't exist
    os.makedirs(os.path.dirname(target_file), exist_ok=True)

    with open(target_file, 'w') as file:
        file.write(f"@define-color foreground {new_colors['foreground']};\n")
        file.write(f"@define-color background {new_colors['background']};\n")
        file.write(f"@define-color cursor {new_colors['cursor']};\n\n")
        
        for i in range(16):
            file.write(f"@define-color color{i} {new_colors[f'color{i}']};\n")  # Write all colors

    print(f"Colors have been exported to: {target_file}")
