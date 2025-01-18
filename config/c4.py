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

def run_matugen(image_path):
    """Run matugen with absolute path."""
    try:
        matugen_path = get_matugen_path()
        if not matugen_path:
            logging.error("Could not find matugen executable")
            return None

        logging.info(f"Using matugen at: {matugen_path}")

        # Set up enhanced environment
        env = os.environ.copy()
        cargo_bin = os.path.expanduser("~/.cargo/bin")
        if cargo_bin not in env.get("PATH", ""):
            env["PATH"] = f"{cargo_bin}:{env.get('PATH', '')}"

        # Run matugen with full path
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

        if result.returncode != 0:
            logging.error(f"Matugen failed with return code {result.returncode}")
            return None

        return result.stdout

    except Exception as e:
        logging.error(f"Unexpected error running matugen: {str(e)}")
        return None

def generate_css_from_json(json_data):
    """Generate a CSS file from JSON data using GTK color definitions."""
    try:
        css_content = ""
        for theme, colors in json_data['colors'].items():
            css_content += f"/* {theme.capitalize()} Theme Colors */\n"
            for color_name, color_value in colors.items():
                r, g, b, a = [round(float(v)) for v in color_value.strip('rgba()').split(',')]
                hex_value = f"#{r:02x}{g:02x}{b:02x}"
                css_content += f"@define-color {theme}-{color_name.replace('_', '-')} {hex_value};\n"
            css_content += "\n"
        return css_content
    except Exception as e:
        logging.error(f"Error generating CSS: {str(e)}")
        return None

def generate_json_from_data(json_data):
    """Generate a JSON file from the provided data."""
    try:
        return json.dumps(json_data, indent=4)
    except Exception as e:
        logging.error(f"Error generating JSON: {str(e)}")
        return None

def generate_scss_from_data(json_data):
    """Generate SCSS file from JSON data."""
    try:
        scss_content = ""
        for theme, colors in json_data['colors'].items():
            scss_content += f"/* {theme.capitalize()} Theme SCSS */\n"
            for color_name, color_value in colors.items():
                r, g, b, a = [round(float(v)) for v in color_value.strip('rgba()').split(',')]
                hex_value = f"#{r:02x}{g:02x}{b:02x}"
                scss_content += f"${theme}-{color_name.replace('_', '-')}: {hex_value};\n"
            scss_content += "\n"
        return scss_content
    except Exception as e:
        logging.error(f"Error generating SCSS: {str(e)}")
        return None

def main(image_path):
    logging.info(f"Starting CSS generation for image: {image_path}")

    # Expand and log paths
    image_path = os.path.abspath(image_path)
    logging.info(f"Full image path: {image_path}")

    # Run matugen with absolute path
    matugen_output = run_matugen(image_path)
    if not matugen_output:
        print("Failed to run matugen. Check the debug log for details.")
        return

    try:
        json_data = json.loads(matugen_output)
    except json.JSONDecodeError as e:
        logging.error(f"Failed to decode JSON: {e}")
        print("Failed to parse matugen output. Check the debug log for details.")
        return

    # Generate and write CSS content
    css_content = generate_css_from_json(json_data)
    if not css_content:
        print("Failed to generate CSS content. Check the debug log for details.")
        return

    css_paths = [
        os.path.expanduser("~/.config/material-you/waybar-colors2.css"),
        os.path.expanduser("~/.config/gtk-3.0/colors.css"),
        os.path.expanduser("~/.config/gtk-4.0/colors1.css")
    ]

    for css_path in css_paths:
        try:
            os.makedirs(os.path.dirname(css_path), exist_ok=True)
            with open(css_path, 'w') as output_file:
                output_file.write(css_content)
            logging.info(f"CSS file generated successfully: {css_path}")
            print(f"CSS file generated successfully: {css_path}")
        except Exception as e:
            logging.error(f"Failed to write CSS file: {str(e)}")
            print(f"Failed to write CSS file. Check the debug log for details.")

    # Generate and write JSON content
    json_output_path = os.path.expanduser("~/.config/material-you/colors.json")
    json_content = generate_json_from_data(json_data)
    if json_content:
        try:
            os.makedirs(os.path.dirname(json_output_path), exist_ok=True)
            with open(json_output_path, 'w') as output_file:
                output_file.write(json_content)
            logging.info(f"JSON file generated successfully: {json_output_path}")
            print(f"JSON file generated successfully: {json_output_path}")
        except Exception as e:
            logging.error(f"Failed to write JSON file: {str(e)}")
            print(f"Failed to write JSON file. Check the debug log for details.")

    # Generate and write SCSS content
    scss_output_path = os.path.expanduser("~/.config/material-you/colors.scss")
    scss_content = generate_scss_from_data(json_data)
    if scss_content:
        try:
            os.makedirs(os.path.dirname(scss_output_path), exist_ok=True)
            with open(scss_output_path, 'w') as output_file:
                output_file.write(scss_content)
            logging.info(f"SCSS file generated successfully: {scss_output_path}")
            print(f"SCSS file generated successfully: {scss_output_path}")
        except Exception as e:
            logging.error(f"Failed to write SCSS file: {str(e)}")
            print(f"Failed to write SCSS file. Check the debug log for details.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <image_path>")
        sys.exit(1)
    image_path = sys.argv[1]
    main(image_path)
