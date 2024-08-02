#!/bin/bash

STATUS=$(nmcli -t -f WIFI g)
CONNECTION=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)

if [[ "$STATUS" == "enabled" ]]; then
    if [[ -n "$CONNECTION" ]]; then
        echo "{\"text\": \"$CONNECTION\", \"class\": \"connected\"}"
    else
        echo "{\"text\": \"No Connection\", \"class\": \"disconnected\"}"
    fi
else
    echo "{\"text\": \"WiFi Off\", \"class\": \"disabled\"}"
fi

