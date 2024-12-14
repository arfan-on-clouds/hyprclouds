#!/bin/bash

# Ensure the PATH includes the directory where kitty is installed
export PATH=$PATH:/usr/bin

# Run spicetify using the absolute path and log output
/home/alien/.spicetify/spicetify apply > /tmp/spicetify.log 2>&1

# Check if the command was successful
if [ $? -eq 0 ]; then
  echo "Spicetify applied successfully."
else
  echo "Spicetify apply failed. Check the log at /tmp/spicetify.log for details."
fi
