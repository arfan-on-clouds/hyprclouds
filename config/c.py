import re
import os

def extract_colors(css_content):
    """
    Extract all color definitions in the format '@define-color name color'.
    """
    pattern = r"@define-color\s+(\w+)\s+(#[0-9a-fA-F]{6});"
    matches = re.findall(pattern, css_content)
    return {name: color for name, color in matches}

def format_colors(color_mapping):
    """
    Format the extracted colors into the desired 'colorX = name' format.
    """
    formatted = []
    predefined_mapping = {
        "dark-background": "background",
        "light-background": "foreground",
        "dark-surface": "color0",
        "background": "color1",
        "dark-on-primary": "color2",
        "dark-on-primary-fixed-variant": "color3",
        "dark-inverse-primary": "color4",
        "light-source-color": "color5",
        "light-tertiary": "color6",
        "dark-primary": "color7",
        "dark-on-primary": "color8",
        "dark-surface-dim": "color9",
        "dark-on-secondary": "color10"
    }

    for name, hex_color in color_mapping.items():
        # Map CSS name to the desired format if predefined, otherwise keep the name
        mapped_name = predefined_mapping.get(name, name)
        formatted.append(f"{mapped_name} = {name} ({hex_color})")

    return "\n".join(formatted)

def main(css_file_path):
    """
    Main function to parse the CSS file and generate formatted color definitions.
    """
    if not os.path.exists(css_file_path):
        print(f"CSS file not found: {css_file_path}")
        return

    with open(css_file_path, "r") as css_file:
        css_content = css_file.read()

    # Extract colors
    color_mapping = extract_colors(css_content)

    # Format colors
    output = format_colors(color_mapping)
    print(output)

if __name__ == "__main__":
    # Replace this with the actual path to your CSS file
    css_file_path = os.path.expanduser("~/.config/material-you/kitty.conf")
