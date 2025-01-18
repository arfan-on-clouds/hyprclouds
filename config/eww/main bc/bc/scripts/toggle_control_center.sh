#!/bin/bash

# Function to open the control center
open_control_center() {
    if [[ -z $(eww windows | grep 'control_center') ]]; then
        eww open control_center
    fi
    eww update open_control_center=true
    # Execute the swayncbottom.sh script
    /home/alien/.config/hypr/scripts/activate-script/swayncbottom.sh
}

# Function to close the control center
close_control_center() {
    eww update open_control_center=false
    # Execute the swayncbottom.sh script
    /home/alien/.config/hypr/scripts/activate-script/swayncbottom.sh
}

# Check the current state of the control center
state=$(eww get open_control_center)

# Handle the 'close' argument
if [[ "$1" == "close" ]]; then
    close_control_center
    exit 0
fi

# Toggle the control center based on its current state
if [[ "$state" == "true" ]]; then
    close_control_center
else
    open_control_center
fi
