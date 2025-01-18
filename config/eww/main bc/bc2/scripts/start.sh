#!/bin/bash
pkill eww
eww daemon
eww open bar
eww open notifications_popup
eww open corner-right
eww open corner-left
python3 ~/.config/eww/scripts/notifications.py &