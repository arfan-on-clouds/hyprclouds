import subprocess
import sys
import os
import configparser

def run_command(command):
    try:
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

def update_waypaper_config(image_path):
    config_path = os.path.expanduser("~/.config/waypaper/config.ini")
    
    config = configparser.ConfigParser()
    config.read(config_path)
    
    if 'Settings' not in config:
        config['Settings'] = {}
    
    config['Settings']['wallpaper'] = image_path
    
    with open(config_path, 'w') as configfile:
        config.write(configfile)
    
    print(f"Updated waypaper configuration with wallpaper: {image_path}")

def main(image_path):
    # Update waypaper configuration
    update_waypaper_config(image_path)
    
    # Set the wallpaper directly
    run_command(['waypaper', '--wallpaper', image_path])
    
    # Define commands to run
    commands = [
        # Update terminal colors with Pywal
        ['hellwal', '-i', image_path],
        ['wal', '-i', image_path],  # '-b', '#000000' can be added if needed

        # Run Python scripts
        ['python', '/home/alien/.config/material-you/c3.py', image_path],
        ['python', '/home/alien/.config/material-you/c2.py', image_path, '1'],
        ['python', '/home/alien/.config/material-you/c1.py', image_path, '1'],
        ['python', '/home/alien/.cache/material-you/c1.py'],
        ['python', '/home/alien/.cache/material-you/c.py'],
        ['python', '/home/alien/.cache/material-you/c2.py'],
        ['python', '/home/alien/.cache/material-you/c3.py'],

        # Copy files
        ['cp', '-f', os.path.expanduser('~/.cache/material-you/colors.json'), os.path.expanduser('~/.cache/wal/')],
        ['cp', '-f', os.path.expanduser('~/.cache/material-you/colors.css'), os.path.expanduser('~/.cache/wal/')],
        ['cp', '-f', os.path.expanduser('~/.cache/material-you/colors'), os.path.expanduser('~/.cache/wal/')],

        # Sway notifications
        ['swaync-client', '-rs', image_path],
        ['python3', '/home/alien/.config/hypr/scripts/parse_css_to_hyprland.py', image_path],

        # Determine theme and run corresponding script
        ['bash', '-c', 'current_theme=$(cat /home/alien/.config/kitty/current_theme.txt) && '
                       'if [ "$current_theme" == "dark" ]; then '
                       '/home/alien/.config/hypr/scripts/rofi_light_dark/rofi_dark.sh "$1"; else '
                       '/home/alien/.config/hypr/scripts/rofi_light_dark/rofi_light.sh "$1"; fi'],

        # Update various applications
        ['pywalfox', 'update'],
        ['wal-telegram', '-r'],
        ['python', '/home/alien/.config/hypr/scripts/material-colors/export-colrs.py'],
        ['python', '/home/alien/.config/hypr/scripts/material-colors/export-colrsW.py'],
        ['python', '/home/alien/.config/hypr/scripts/kitty-colors/kitty-dark.py'],
        ['python', '/home/alien/.config/hypr/scripts/kitty-colors/kitty-light.py'],
        ['python', '/home/alien/.config/hypr/scripts/kitty-colors/selector.py'],
        ['/home/alien/.config/hypr/scripts/Discord/dark.sh'],
        ['/home/alien/.cache/material-you/color-generator.sh'],
        ['/home/alien/.config/hypr/scripts/rofi_light_dark/lightcolors.sh'],
        ['/home/alien/.config/hypr/scripts/rofi_light_dark/darkcolors.sh'],
        ['wal-telegram', '--palette', os.path.expanduser('~/.cache/material-you/colors.sh')],

        # Handle wallpapers
        ['bash', '-c', f'ROFI_WALLPAPER_PATH="/home/alien/.config/rofi/launchers/type-6/current-wallpaper.png" && '
                       f'FIREFOX_WALLPAPER_PATH="/home/alien/.mozilla/firefox/n5hfb426.new1/chrome/wallpaper.png" && '
                       f'FIREFOX_LIGHT_WALLPAPER_PATH="/home/alien/.mozilla/firefox/n5hfb426.new1/chrome/wallpaper-light.png" && '
                       f'if [ -e "$ROFI_WALLPAPER_PATH" ]; then rm "$ROFI_WALLPAPER_PATH"; fi && '
                       f'cp "{image_path}" "$ROFI_WALLPAPER_PATH" && '
                       f'cp "{image_path}" "$FIREFOX_WALLPAPER_PATH" && '
                       f'cp "{image_path}" "$FIREFOX_LIGHT_WALLPAPER_PATH" && '
                       f'if [ ! -L "$ROFI_WALLPAPER_PATH" ]; then echo "Failed to create the symbolic link for the wallpaper."; exit 1; fi && '
                       f'cp "{image_path}" "$FIREFOX_WALLPAPER_PATH" && '
                       f'cp "{image_path}" "$FIREFOX_LIGHT_WALLPAPER_PATH" && '
                       f'if [ ! -L "$FIREFOX_WALLPAPER_PATH" ] || [ ! -L "$FIREFOX_LIGHT_WALLPAPER_PATH" ]; then echo "Failed to create the symbolic links for the Firefox wallpapers."; exit 1; fi && '
                       f'echo "Rofi and Firefox wallpapers updated successfully."']
    ]

    # Run all commands
    for command in commands:
        run_command(command)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python c4.py <image_path>")
        sys.exit(1)

    image_path = sys.argv[1]
    main(image_path)
