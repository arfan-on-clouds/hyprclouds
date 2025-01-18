#!/bin/bash

# Toggle the "Do Not Disturb" state

# Variable to store the current state
CURRENT_STATE=$(gsettings get org.gnome.desktop.notifications show-banners)

# Remove any single quotes from the result
CURRENT_STATE=${CURRENT_STATE//\'/}

# Toggle the state
if [ "$CURRENT_STATE" = "true" ]; then
    # Disable notifications
    gsettings set org.gnome.desktop.notifications show-banners false
    echo "Do Not Disturb enabled."
else
    # Enable notifications
    gsettings set org.gnome.desktop.notifications show-banners true
    echo "Do Not Disturb disabled."
fi
