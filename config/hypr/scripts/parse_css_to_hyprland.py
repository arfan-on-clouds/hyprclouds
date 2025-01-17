import re

css_file = "/home/alien/.cache/hellwal/colors.css"
hyprland_conf_file = "/home/alien/.cache/material-you/hyprland.conf"

def parse_css(css_file):
    with open(css_file, 'r') as f:
        css_content = f.read()
    
    # Regex to find all CSS variables including special ones
    pattern = re.compile(r'--(color\d+|background|foreground|cursor):\s*(#[0-9a-fA-F]{6});')
    colors = pattern.findall(css_content)
    
    return colors

def hex_to_rgb(hex_color):
    return f"rgb({hex_color[1:]})"

def generate_hyprland_conf(colors, output_file):
    with open(output_file, 'w') as f:
        for name, color in colors:
            rgb = hex_to_rgb(color)
            f.write(f"${name} = {rgb}\n")

colors = parse_css(css_file)
generate_hyprland_conf(colors, hyprland_conf_file)
