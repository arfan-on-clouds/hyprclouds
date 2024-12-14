import re

def blend_color(fixed_color, blend_color, ratio=0.4):
    """Blend two colors with a given ratio (60% base, 40% blend)."""
    fixed_color = fixed_color.lstrip('#')
    blend_color = blend_color.lstrip('#')
    
    # Extract RGB components from both colors
    fr, fg, fb = int(fixed_color[0:2], 16), int(fixed_color[2:4], 16), int(fixed_color[4:6], 16)
    br, bg, bb = int(blend_color[0:2], 16), int(blend_color[2:4], 16), int(blend_color[4:6], 16)
    
    # Apply the 60/40 blending rule (60% base, 40% blend)
    rr = int(fr * (1 - ratio) + br * ratio)
    rg = int(fg * (1 - ratio) + bg * ratio)
    rb = int(fb * (1 - ratio) + bb * ratio)
    
    # Return the blended color as a hex string
    return f'#{rr:02x}{rg:02x}{rb:02x}'

def adjust_colors(css_content):
    """Adjust background and foreground colors in the CSS content."""
    # Define the base colors to blend with (60% base, 40% blend)
    constant_dark_background = '#010101'  # Dark background color
    fixed_foreground = '#fcfcfc'  # Light foreground to contrast with dark background
    
    # Use regex to find background and foreground colors in the CSS content
    background_color_match = re.search(r'--background:\s*(#[0-9a-fA-F]{6})', css_content)
    foreground_color_match = re.search(r'--foreground:\s*(#[0-9a-fA-F]{6})', css_content)
    
    # Apply the 60/40 blending for background
    if background_color_match:
        background_color = background_color_match.group(1)
        new_background_color = blend_color(constant_dark_background, background_color, ratio=0.4)
        css_content = re.sub(r'(--background:\s*)(#[0-9a-fA-F]{6})', f'\\1{new_background_color}', css_content)
    
    # Apply the 60/40 blending for foreground
    if foreground_color_match:
        foreground_color = foreground_color_match.group(1)
        new_foreground_color = blend_color(fixed_foreground, foreground_color, ratio=0.4)
        css_content = re.sub(r'(--foreground:\s*)(#[0-9a-fA-F]{6})', f'\\1{new_foreground_color}', css_content)
    
    return css_content

def main(input_css_path, output_css_path):
    # Read the input CSS file
    with open(input_css_path, "r") as file:
        css_content = file.read()

    # Adjust the colors using the 60/40 blending rule
    adjusted_css_content = adjust_colors(css_content)

    # Write the adjusted CSS content back to the file
    with open(output_css_path, "w") as file:
        file.write(adjusted_css_content)

    print(f"Adjusted CSS content written to {output_css_path}")

if __name__ == "__main__":
    # Define the paths to the input and output CSS files
    input_css_path = "/home/alien/.cache/hellwal/colors.css"  # Update this to your input file path
    output_css_path = "/home/alien/.cache/material-you/colors.css"  # Update this to your output file path
    
    # Run the script
    main(input_css_path, output_css_path)
