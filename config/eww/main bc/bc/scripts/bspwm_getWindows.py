#!/usr/bin/python

import json
from sys import exit as sysexit
from sys import argv as args
from subprocess import PIPE, run as shellRun, getoutput as shellOut, Popen as shellPopen

from apps import get_gtk_icon as getIcon

def get_window_info(window_id):
    try:
        data = json.loads(shellOut(f"bspc query -T -n {window_id}"))
        client = data["client"]
        id = data["id"]
        icon = getIcon(client["className"])
        name = client["className"].capitalize()
        floating = client["state"] == "floating"
        key = "floatingRectangle" if floating else "tiledRectangle"
        
        at = [client[key]["x"], client[key]["y"]]
        size = [client[key]["width"], client[key]["height"]]
        
        return {
            "window_id": str(id),
            "window_icon": str(icon),
            "window_name": str(name),
            "floating": floating,
            "at": at,
            "size": size
        }
    except:
        pass

def get_workspace_windows():
    workspace_info = []

    for workspace in shellOut("bspc query -D --names").split():
        windows_info = [get_window_info(window) for window in shellOut(f"bspc query -N -d {workspace}").split() if get_window_info(window)]
        
        workspace_dict = {
            "workspace": str(workspace),
            "windows": windows_info
        }
        workspace_info.append(workspace_dict)
    
    return workspace_info

# Function to update Eww with window entries
def update_eww(entries):
    shellRun(["eww", "update", f"windows={json.dumps(entries)}"])

# Subscribe to window changes
proc = shellPopen(["bspc", "subscribe", "node_add", "node_remove"], stdout=PIPE, text=True)

if __name__ == "__main__":
    if "--once" in args:
        print(get_workspace_windows())
        update_eww(get_workspace_windows())
    else:
        while True:
            _ = proc.stdout.readline()
            window_active = (json.loads(shellOut("bspc query -T -n $(bspc query -N -n focused)")))["id"]
            update_eww(get_workspace_windows())
