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

def main(input_json_path, output_json_path):
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

    # Prepare the output JSON structure
    output_data = {
        "wallpaper": "/home/alien/Documents/colorswall/Windows 11/windows-3.png",
        "alpha": "100",
        "special": json_data.get("special", {}).copy(),  # Copy the special section
        "colors": json_data.get("colors", {}).copy()    # Copy the colors section
    }

    # Adjust the colors in the special section
    output_data['special'] = adjust_colors(output_data['special'])

    # Write the adjusted JSON content back to the file
    with open(output_json_path, "w") as file:
        json.dump(output_data, file, indent=4)

    print(f"Adjusted JSON config written to {output_json_path}")

if __name__ == "__main__":
    # Define the paths to the input and output JSON files
    input_json_path = "/home/alien/.cache/hellwal/colors.json"  # Update this to your input file path
    output_json_path = "/home/alien/.cache/material-you/colors.json"  # Update this to your output file path
    
    # Run the script
    main(input_json_path, output_json_path)