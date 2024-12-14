import re

def blend_color(fixed_color, blend_color, ratio=0.4):
    """Blend two colors with a given ratio (60% base, 40% blend)."""
    fixed_color = fixed_color.lstrip('#')
    blend_color = blend_color.lstrip('#')
    
    # Extract RGB components from both colors
    fr, fg, fb = int(fixed_color[0:2], 16), int(fixed_color[2:4], 16), int(fixed_color[4:6], 16)
    br, bg, bb = int(blend_color[0:2], 16), int(blend_color[2:4], 16), int(blend_color[4:6], 16)
    
    # Apply the blending ratio (60% base, 40% blend)
    rr = int(fr * (1 - ratio) + br * ratio)
    rg = int(fg * (1 - ratio) + bg * ratio)
    rb = int(fb * (1 - ratio) + bb * ratio)
    
    return f'#{rr:02x}{rg:02x}{rb:02x}'

def adjust_colors(content):
    """Adjust background and foreground colors in the content."""
    fixed_background = '#010101'  # Base dark color to blend towards (60% base, 40% blend)
    fixed_foreground = '#fcfcfc'  # Lighter foreground color for blending
    
    # Extract background and foreground colors
    background_color_match = re.search(r'--background\s*:\s*(#[0-9a-fA-F]{6})', content)
    foreground_color_match = re.search(r'--foreground\s*:\s*(#[0-9a-fA-F]{6})', content)
    
    if background_color_match:
        background_color = background_color_match.group(1)
        
        # Apply 60% base color and 40% blend color for darkening
        new_background_color = blend_color(fixed_background, background_color, ratio=0.4)
        
        content = re.sub(r'(--background\s*:\s*)(#[0-9a-fA-F]{6})', f'\\1{new_background_color};', content)
    
    if foreground_color_match:
        foreground_color = foreground_color_match.group(1)
        # Apply 80% base foreground color and 20% blend for adjusting foreground
        new_foreground_color = blend_color(fixed_foreground, foreground_color, ratio=0.2)
        content = re.sub(r'(--foreground\s*:\s*)(#[0-9a-fA-F]{6})', f'\\1{new_foreground_color};', content)
    
    return content

def convert_to_waybar_format(content):
    """Convert the adjusted content to Waybar format."""
    lines = content.split('\n')
    waybar_lines = []

    for line in lines:
        match = re.match(r'\s*--(\w+)\s*:\s*(#[0-9a-fA-F]{6})\s*;', line)
        if match:
            var_name = match.group(1)
            color_value = match.group(2)
            waybar_lines.append(f'@define-color {var_name} {color_value};')
    
    return '\n'.join(waybar_lines)

def main(input_path, output_path):
    # Read the input file
    with open(input_path, "r") as file:
        content = file.read()

    # Adjust the colors
    adjusted_content = adjust_colors(content)

    # Convert to Waybar format
    waybar_content = convert_to_waybar_format(adjusted_content)

    # Write the adjusted content back to the file
    with open(output_path, "w") as file:
        file.write(waybar_content)

    print(f"Adjusted Waybar content written to {output_path}")

if __name__ == "__main__":
    input_css_path = "/home/alien/.cache/hellwal/colors.css"  # Update this to your input file path
    output_css_path = "/home/alien/.cache/material-you/waybar-colors.css"  # Update this to your output file path
    
    main(input_css_path, output_css_path)
