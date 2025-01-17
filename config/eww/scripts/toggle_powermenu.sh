#!/bin/bash

if [[ -z $(eww windows | grep '*powermenu') ]]; then
    eww open powermenu
    eww open powercorner-left
    eww open powercorner-left
elif [[ -n $(eww windows | grep '*powermenu') ]];then
    eww close powermenu
    eww close powercorner-left
    eww close powercorner-left
fi