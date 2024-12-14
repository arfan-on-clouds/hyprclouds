import json

def blend_color(fixed_color, blend_color, ratio=0.4):
    """Blend two colors with a given ratio."""
    fixed_color = fixed_color.lstrip('#')
    blend_color = blend_color.lstrip('#')
    
    # Extract RGB components from both colors
    fr, fg, fb = int(fixed_color[0:2], 16), int(fixed_color[2:4], 16), int(fixed_color[4:6], 16)
    br, bg, bb = int(blend_color[0:2], 16), int(blend_color[2:4], 16), int(blend_color[4:6], 16)
    
    # Apply the blending rule
    rr = int(fr * (1 - ratio) + br * ratio)
    rg = int(fg * (1 - ratio) + bg * ratio)
    rb = int(fb * (1 - ratio) + bb * ratio)
    
    # Return the blended color as a hex string
    return f'#{rr:02x}{rg:02x}{rb:02x}'

def adjust_colors(special_section):
    """Adjust background and foreground colors in the special section."""
    # Define the base colors to blend with
    constant_dark_background = '#010101'  # Dark background color
    fixed_foreground = '#fcfcfc'  # Light foreground to contrast with dark background
    
    # Apply the blending for background
    if 'background' in special_section:
        background_color = special_section['background']
        new_background_color = blend_color(constant_dark_background, background_color, ratio=0.4)
        special_section['background'] = new_background_color
    
    # Apply the blending for foreground
    if 'foreground' in special_section:
        foreground_color = special_section['foreground']
        new_foreground_color = blend_color(fixed_foreground, foreground_color, ratio=0.4)
        special_section['foreground'] = new_foreground_color
    
    return special_section

def format_colors_for_txt(json_data):
    """Format the colors for txt file output."""
    colors = [
        "#020505",
        "#e6fdec",
        "#e6fdec",
        "#e6fdec",
        "",
        "#020505",
        "#040c0c",
        "#2a4247",
        "#33493f",
        "#3c4e45",
        "#3a5b54",
        "#40654b",
        "#5f877a",
        "#95c5a1",
        "#143332",
        "#345258",
        "#3f5b4e",
        "#4b6156",
        "#487169",
        "#507e5d",
        "#76a898",
        "#c7ffd6"
    ]
    
    return "\n".join(colors)

def main(input_json_path, output_txt_path):
    # Read the input JSON file
    try:
        with open(input_json_path, "r") as file:
            json_data = json.load(file)
    except FileNotFoundError:
        print(f"Error: The file {input_json_path} does not exist.")
        return
    except json.JSONDecodeError:
        print(f"Error: The file {input_json_path} is not valid JSON.")
        return

    # Adjust the colors in the special section
    json_data['special'] = adjust_colors(json_data.get('special', {}))

    # Format the colors for the txt output
    txt_colors = format_colors_for_txt(json_data)

    # Write the formatted colors to the output txt file
    with open(output_txt_path, "w") as file:
        file.write(txt_colors)

    print(f"Adjusted colors written to {output_txt_path}")

if __name__ == "__main__":
    # Define the paths to the input JSON and output TXT files
    input_json_path = "/home/alien/.cache/hellwal/colors.json"  # Update this to your input file path
    output_txt_path = "/home/alien/.cache/material-you/colors"  # Update this to your output file path
    
    # Run the script
    main(input_json_path, output_txt_path)
