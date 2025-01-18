#!/bin/bash
state=$(eww get open_control_center)

case $1 in
    close)
        eww update open_control_center=false
        eww close control_center
        eww close corner-right
        eww close topcorner-right
        exit 0
        ;;
esac

case $state in
    true)
        eww update open_control_center=false
        eww close control_center
        eww close corner-right
        eww close topcorner-right
        ;;
    false)
        eww open control_center
        eww open corner-right
        eww open topcorner-right
        eww update open_control_center=true
        ;;
esac
