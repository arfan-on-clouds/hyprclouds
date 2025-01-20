#!/bin/bash

# Initialize variables for volume and widget states
vol="$(eww get volume)"

# Function to open widgets
open_widgets() {
  eww open osd
  eww open volcorner-right
  eww open volcorner-left

  eww update open_osd=true
  eww update open_volcorner_right=true
  eww update open_volcorner_left=true
}

# Function to close widgets
close_widgets() {
  eww update open_osd=false
  eww update open_volcorner_right=false
  eww update open_volcorner_left=false

  eww close osd
  eww close volcorner-right
  eww close volcorner-left
}

# Open the widgets initially
open_widgets

while true; do
  sleep 2.5

  # Check for volume changes
  new_vol=$(eww get volume)

  if [ "$vol" != "$new_vol" ]; then
    vol="$new_vol"
  else
    newest_vol=$(eww get volume)
    if [ "$vol" == "$newest_vol" ]; then
      # Close the widgets if no changes are detected
      close_widgets
      exit
    fi
  fi
done
