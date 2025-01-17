import subprocess
import json
import os
import sys
import logging
from pathlib import Path

# Set up logging
logging.basicConfig(
    level=logging.DEBUG,
    filename=os.path.expanduser('~/.config/material-you/debug.log'),
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def get_matugen_path():
    """Get the absolute path to matugen executable."""
    # First try the known cargo location
    cargo_matugen = os.path.expanduser("~/.cargo/bin/matugen")
    if os.path.exists(cargo_matugen):
        return cargo_matugen
    
    # Fall back to PATH search
    try:
        result = subprocess.run(['which', 'matugen'], 
                              capture_output=True, 
                              text=True)
        if result.returncode == 0:
            return result.stdout.strip()
    except Exception:
        pass
    
    return None

def generate_css_from_json(json_data):
    """Generate a CSS file from JSON data using CSS variables."""
    try:
        css_content = ":root {\n"
        # Loop through light and dark theme colors
        for theme, colors in json_data['colors'].items():
            css_content += f"  /* {theme.capitalize()} Theme Colors */\n"
            for color_name, color_value in colors.items():
                # Convert RGBA to hex format, rounding float values to the nearest integer
                r, g, b, a = [round(float(v)) for v in color_value.strip('rgba()').split(',')]
                hex_value = f"#{r:02x}{g:02x}{b:02x}"
                css_content += f"  --{theme}-{color_name.replace('_', '-')}: {hex_value};\n"
        css_content += "}\n"
        return css_content
    except Exception as e:
        logging.error(f"Error generating CSS: {str(e)}")
        return None

def main(image_path, output_path='~/.config/material-you/colors2.css'):
    logging.info(f"Starting CSS generation for image: {image_path}")
    
    # Expand and log paths
    output_path = os.path.expanduser(output_path)
    image_path = os.path.abspath(image_path)
    logging.info(f"Full image path: {image_path}")
    logging.info(f"Full output path: {output_path}")
    
    # Check if the image file exists
    if not os.path.isfile(image_path):
        error_msg = f"Image file not found: {image_path}"
        logging.error(error_msg)
        print(error_msg)
        return
    
    # Get matugen path
    matugen_path = get_matugen_path()
    if not matugen_path:
        error_msg = "Could not find matugen executable"
        logging.error(error_msg)
        print(error_msg)
        return
    
    logging.info(f"Using matugen at: {matugen_path}")
    
    # Set up enhanced environment
    env = os.environ.copy()
    cargo_bin = os.path.expanduser("~/.cargo/bin")
    if cargo_bin not in env.get("PATH", ""):
        env["PATH"] = f"{cargo_bin}:{env.get('PATH', '')}"
    
    # Run matugen with full path
    try:
        result = subprocess.run(
            [matugen_path, '--json', 'rgba', 'image', image_path],
            capture_output=True,
            text=True,
            env=env,
            check=False
        )
        
        logging.info(f"Command executed: {matugen_path} --json rgba image {image_path}")
        logging.info(f"Return code: {result.returncode}")
        
        if result.stderr:
            logging.error(f"Stderr: {result.stderr}")
            print("Matugen Error:", result.stderr)
        
        if result.returncode != 0:
            error_msg = f"Matugen failed with return code {result.returncode}"
            logging.error(error_msg)
            print(error_msg)
            return
            
        print("Matugen Output:", result.stdout)
        
        try:
            json_data = json.loads(result.stdout)
        except json.JSONDecodeError as e:
            error_msg = f"Failed to decode JSON: {e}"
            logging.error(error_msg)
            print(error_msg)
            return
        
        # Generate CSS content
        css_content = generate_css_from_json(json_data)
        if not css_content:
            print("Failed to generate CSS content. Check the debug log for details.")
            return
        
        # Ensure the directory exists
        try:
            os.makedirs(os.path.dirname(output_path), exist_ok=True)
        except Exception as e:
            error_msg = f"Failed to create directory: {str(e)}"
            logging.error(error_msg)
            print(error_msg)
            return
        
        # Write the CSS content
        try:
            with open(output_path, 'w') as css_file:
                css_file.write(css_content)
            logging.info("CSS file generated successfully")
            print(f"CSS file generated successfully: {output_path}")
        except Exception as e:
            error_msg = f"Failed to write CSS file: {str(e)}"
            logging.error(error_msg)
            print(error_msg)
            
    except Exception as e:
        error_msg = f"Unexpected error running matugen: {str(e)}"
        logging.error(error_msg)
        print(error_msg)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <image_path>")
        sys.exit(1)
    image_path = sys.argv[1]
    main(image_path)
