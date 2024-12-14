import os
import re

# Define source and target files
source_file = os.path.expanduser("~/.cache/material-you/colors.css")
target_files = [
    os.path.expanduser("~/.themes/Material-wal/gtk-3.0/colors.css"),
    os.path.expanduser("/home/alien/.config/gtk-4.0/colors1.css")
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

# Extract colors from the source file
foreground = extract_color(content, '--foreground')
background = extract_color(content, '--background')
cursor = extract_color(content, '--cursor')

# Extract color0 to color15
colors = [extract_color(content, f'--color{i}') for i in range(16)]

# Function to write colors to target file
def write_colors_to_file(target_file):
    # Create the target directory if it doesn't exist
    os.makedirs(os.path.dirname(target_file), exist_ok=True)
    
    # Write the colors to the target file
    with open(target_file, 'w') as file:
        file.write(f"@define-color foreground {foreground};\n")
        file.write(f"@define-color background {background};\n")
        file.write(f"@define-color cursor {cursor};\n\n")
        
        for i, color in enumerate(colors):
            file.write(f"@define-color color{i} {color};\n")

# Write colors to each target file
for target_file in target_files:
    write_colors_to_file(target_file)
    print(f"Colors have been exported to: {target_file}")
