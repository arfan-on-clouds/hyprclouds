#!/bin/bash
pkill eww
eww daemon
eww open bar
eww open notifications_popup
eww open taskbar-left
python3 ~/.config/eww/scripts/notifications.py &
eww open bgcorner-right
eww open bgcorner-left
eww open corner1
eww open corner2