import json

# Input and output file paths
input_file_path = 'colors.json'  # Path to the JSON file
output_file_path = 'colors.css'  # Output file for @define-color format

def convert_json_to_define_color(input_path, output_path):
    with open(input_path, 'r') as json_file:
        data = json.load(json_file)
    
    colors = data.get('colors', {}).get('dark', {})
    
    with open(output_path, 'w') as css_file:
        for key, value in colors.items():
            css_file.write(f'@define-color {key} {value};\n')
    
    print(f'Converted JSON to {output_path}.')

# Run the conversion
convert_json_to_define_color(input_file_path, output_file_path)
