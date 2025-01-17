#!/bin/bash
# Get the album art URL from Spotify via playerctl
album_art=$(playerctl -p spotify metadata mpris:artUrl)

if [[ -z $album_art ]]; then
   # Exit if no album art URL is found
   exit
fi

# Download the album art and save it to a temporary file
curl -s "${album_art}" --output "/tmp/cover.jpeg"

# Output the path to the downloaded image
echo "/tmp/cover.jpeg"
