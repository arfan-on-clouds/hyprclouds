#!/bin/bash

# Check if the calendar is open
if [[ $(eww get open_calendar) == "true" ]]; then
    # Close the calendar if it is open
    eww update open_calendar=false
    eww close calendar
else
    # Open the calendar if it is not open
    eww update open_calendar=true
    eww open calendar
fi
