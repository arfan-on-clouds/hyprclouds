#!/usr/bin/python

import subprocess
import json
import os
import sys
from apps import get_gtk_icon as getIcon

SIGNATURE = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE")

def get_workspace_windows():
    out = subprocess.getoutput("hyprctl clients -j")
    entries = json.loads(out)
    workspaces_info = {}

    for entry in entries:
        workspace_id = entry["workspace"]["id"]

        if entry["class"] == "":
            continue

        if workspace_id not in workspaces_info:
            workspaces_info[workspace_id] = {
                "workspace": str(workspace_id),
                "windows": []
            }

        dict = {
            "window_id": str(entry["address"]),
            "window_icon": getIcon(entry["class"]),
            "window_name": str(entry["class"].capitalize()),
            "focused": str(entry["address"] == get_active_window()),
            "floating": str(entry["floating"]),
            "at": str(entry["at"]),
            "size": str(entry["size"])
        }

        workspaces_info[workspace_id]["windows"].append(dict)

    # Ordenar workspaces por ID
    sorted_workspaces = sorted(workspaces_info.values(), key=lambda x: int(x["workspace"]))


    return sorted_workspaces

def get_active_window():
    out = subprocess.getoutput("hyprctl activewindow -j | jq .address").replace("\"", "")
    return out

def update_eww(entries):
    subprocess.run(["eww", "update", f"windows='{json.dumps(entries)}'"])


if __name__ == "__main__":
    if "--once" in sys.argv:
        print(get_workspace_windows())
        update_eww(get_workspace_windows())

    else:
        
        proc = subprocess.Popen(["socat", "-u", f"UNIX-CONNECT:/tmp/hypr/{SIGNATURE}/.socket2.sock", "-"], stdout=subprocess.PIPE, text=True)

        while True:
            _ = proc.stdout.readline()

            print(get_workspace_windows())
            update_eww(get_workspace_windows())
