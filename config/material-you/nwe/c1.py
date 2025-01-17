import sys
import os
from materialyoucolor.scheme import Scheme
from materialyoucolor.quantize import QuantizeCelebi, StbLoadImage
from materialyoucolor.score.score import Score

def extract_main_color(image_path, quality=1, downsample_factor=0.5):
    """
    Extract the main color from the image, downsample for faster processing.
    :param image_path: Path to the input image.
    :param quality: Quality factor for quantization (lower = faster).
    :param downsample_factor: Factor to downscale the image before processing (between 0 and 1).
    :return: The dominant color extracted from the image.
    """
    image_data = StbLoadImage(image_path)
    image_data_downsampled = [image_data[i] for i in range(0, len(image_data), quality)]
    result = QuantizeCelebi(image_data_downsampled, 128)
    return Score.score(result)[0]

def blend_colors(color1, color2, ratio1, ratio2):
    """
    Blend two colors together using a specified ratio.
    :param color1: The first color (RGB format).
    :param color2: The second color (RGB format).
    :param ratio1: The weight of the first color in the blend (0 to 1).
    :param ratio2: The weight of the second color in the blend (0 to 1).
    :return: The blended color as a list of RGB values.
    """
    return [
        int(c1 * ratio1 + c2 * ratio2) for c1, c2 in zip(color1, color2)
    ]

def rgb_to_hex(rgb):
    """
    Convert RGB list to hex color string.
    :param rgb: List of RGB values [r, g, b]
    :return: Hex color string (e.g., '#FF00FF')
    """
    return '#{:02x}{:02x}{:02x}'.format(rgb[0], rgb[1], rgb[2])

def get_default_waybar_paths():
    """
    Get default waybar configuration paths.
    :return: List of common waybar configuration paths
    """
    home = os.path.expanduser("~")
    return [
        f"{home}/.config/gtk-4.0/colors1.css",
         f"{home}/.config/gtk-3.0/colors.css",
        f"{home}/.config/material-you/waybar-colors.css",
        f"/home/alien/.themes/Material-wal/gtk-3.0/colors.css"
    ]

def ensure_directory_exists(filepath):
    """
    Create directory if it doesn't exist.
    :param filepath: Path to the file
    """
    directory = os.path.dirname(filepath)
    if directory and not os.path.exists(directory):
        try:
            os.makedirs(directory)
            print(f"Created directory: {directory}")
        except Exception as e:
            print(f"Could not create directory {directory}: {e}")

def generate_css(color_int, output_paths=None):
    if output_paths is None:
        output_paths = get_default_waybar_paths()
    
    # Generate the light and dark theme using materialyoucolor
    light = Scheme.light(color_int).props
    dark = Scheme.dark(color_int).props

    # Extract primary colors
    color_keys = [
        'primary', 'secondary', 'tertiary', 'background', 'surface',
        'error', 'outline', 'onPrimary', 'onSecondary', 'onTertiary',
        'onError', 'onBackground', 'onSurface'
    ]
    
    css_content = ""
    # Generate @define-color rules for light theme
    css_content += "/* Light Theme Colors */\n"
    for color in color_keys:
        light_color = light.get(color, [0, 0, 0])
        css_content += f"@define-color light-{color} {rgb_to_hex(light_color)};\n"

    # Blend 90% pitch black with 10% dark-onPrimary for the dark-background color
    pitch_black = [13, 13, 13]  # RGB for pitch black (#0d0d0d)
    dark_onPrimary = dark.get('onPrimary', [0, 0, 0])  # RGB for dark-onPrimary
    dark_background_color = blend_colors(pitch_black, dark_onPrimary, ratio1=0.90, ratio2=0.10)
    
    # Blend 85% pitch black with 15% light-primary for the dark-surface color
    light_primary = light.get('primary', [0, 0, 0])  # RGB for light-primary
    dark_surface_color = blend_colors(pitch_black, light_primary, ratio1=0.85, ratio2=0.15)
    
    # Apply these blended colors to the background and surface
    css_content += f"\n/* Dark Theme Colors */\n"
    for color in color_keys:
        dark_color = dark.get(color, [0, 0, 0])
        # Apply the new blended dark-background and dark-surface colors
        if color == 'background':
            dark_color = dark_background_color
        elif color == 'surface':
            dark_color = dark_surface_color
        css_content += f"@define-color dark-{color} {rgb_to_hex(dark_color)};\n"

    # Write the CSS to all specified output files
    for path in output_paths:
        try:
            ensure_directory_exists(path)
            with open(path, 'w') as f:
                f.write(css_content)
            print(f"Successfully wrote colors to: {path}")
        except Exception as e:
            print(f"Failed to write to {path}: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <image_path> <quality>")
        sys.exit(1)

    image_path = sys.argv[1]
    quality = int(sys.argv[2])

    # Extract the dominant color from the image
    main_color = extract_main_color(image_path, quality)
    # Generate the CSS based on the main color extracted
    generate_css(main_color)
