#!/bin/bash
state=$(eww get open_control_center)

case $1 in
    close)
        eww update open_control_center=false
        eww close control_center
        exit 0
        ;;
esac

case $state in
    true)
        eww update open_control_center=false
        eww close control_center
        ;;
    false)
        eww open control_center
        eww update open_control_center=true
        ;;
esac