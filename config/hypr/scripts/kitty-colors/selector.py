import os
import re  # Import the 're' module for regular expressions
import shutil

# Define paths
theme_file = os.path.expanduser("~/.config/kitty/current_theme.txt")
kitty_config_file = os.path.expanduser("~/.config/kitty/kitty.conf")
light_theme_file = os.path.expanduser("~/.config/kitty/light/kitty.conf")
dark_theme_file = os.path.expanduser("~/.config/kitty/dark/kitty.conf")

# Ensure the theme file exists
if not os.path.isfile(theme_file):
    print(f"Theme file not found: {theme_file}")
    exit(1)

# Read the current theme
with open(theme_file, 'r') as file:
    current_theme = file.read().strip().lower()

# Determine the source theme file based on the current theme
if current_theme == "dark":
    source_file = dark_theme_file
elif current_theme == "light":
    source_file = light_theme_file
else:
    print(f"Unknown theme: {current_theme}")
    exit(1)

# Ensure the source theme file exists
if not os.path.isfile(source_file):
    print(f"Source theme file not found: {source_file}")
    exit(1)

# Read the existing Kitty configuration file
if not os.path.isfile(kitty_config_file):
    print(f"Kitty configuration file not found: {kitty_config_file}")
    exit(1)

with open(kitty_config_file, 'r') as file:
    kitty_config = file.read()

# Read the source theme file
with open(source_file, 'r') as file:
    theme_content = file.read()

# Replace or add the color section in the Kitty configuration file
start_marker = "#BEGIN_COLORS"
end_marker = "#END_COLORS"

# Check if color section exists
if start_marker in kitty_config and end_marker in kitty_config:
    # Update the existing color section
    updated_config = re.sub(
        rf'{start_marker}.*?{end_marker}',
        f'{start_marker}\n{theme_content}\n{end_marker}',
        kitty_config,
        flags=re.DOTALL
    )
else:
    # Add the color section at the end of the file
    updated_config = kitty_config + f"\n{start_marker}\n{theme_content}\n{end_marker}\n"

# Write the updated configuration back to the Kitty configuration file
with open(kitty_config_file, 'w') as file:
    file.write(updated_config)

print(f"Kitty configuration has been updated with the {current_theme} theme colors.")
