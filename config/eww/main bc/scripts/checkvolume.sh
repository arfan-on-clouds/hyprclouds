#!/bin/bash

# Prevent multiple instances of the script
if pidof -o %PPID -x "$(basename "$0")" > /dev/null; then
  exit
fi

vol="$(eww get volume)"

# Open OSD and volume corners if not already open
if [[ $(eww get open_osd) == false ]]; then
  eww open osd
  eww open volcorner-right
  eww open volcorner-left
  eww update open_osd=true
fi

# Monitor volume changes
while true; do
  sleep 1.5  # Reduce delay for better responsiveness

  new_vol=$(eww get volume)

  if [ "$vol" != "$new_vol" ]; then
    vol="$new_vol"
  else
    # Ensure volume is stable before closing OSD and volume corners
    newest_vol=$(eww get volume)
    if [ "$vol" == "$newest_vol" ]; then
      if [[ $(eww get open_osd) == true ]]; then
        eww update open_osd=false
        eww close volcorner-right
        eww close volcorner-left
        exit
      fi
    fi
  fi
done
