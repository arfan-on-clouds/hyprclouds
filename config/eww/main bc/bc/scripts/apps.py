#!/usr/bin/python


import glob
import sys
import os
import json
from subprocess import run as shellRun
import gi
from configparser import ConfigParser

from math import sqrt, pi, sin, cos, tan

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk



# Path to the JSON file used for caching application data
jsonPath = os.path.expanduser("~/.cache/eww/apps.json")
desktop_files = glob.glob(os.path.join("/usr/share/applications", "*.desktop"))

PREFERRED_APPS = []
BLACKLISTED_APPS = []
BLACKLISTED_SUBSTRINGS = [
    "avahi",
    "wayland"
]

def get_gtk_icon(icon_name, extension=""):
    if icon_name is not None:
        theme = Gtk.IconTheme.get_default()

        for name in [f"{icon_name}{extension.lower()}", icon_name.lower(), icon_name.title(), icon_name]:
            icon_info = theme.lookup_icon(name, 128, 0)
            if icon_info is not None:
                return icon_info.get_filename()

        # Si el ícono especificado no se encuentra, buscar el ícono de "applets template"
        applets_template_info = theme.lookup_icon("applets-template", 128, 0)
        if applets_template_info is not None:
            return applets_template_info.get_filename()

    return None


def get_desktop_entries(file_path):
    parser = ConfigParser()
    parser.read(file_path)
    app_name = parser.get("Desktop Entry", "Name")

    if any(substring in app_name.lower() for substring in BLACKLISTED_SUBSTRINGS) or app_name in BLACKLISTED_APPS or parser.getboolean("Desktop Entry", "NoDisplay", fallback=False) and app_name != "Widget Factory":
        return None

    icon_path = get_gtk_icon(parser.get("Desktop Entry", "Icon", fallback=None))
    comment = parser.get("Desktop Entry", "Comment", fallback=None)

    if comment is None:
        comment = parser.get("Desktop Entry", "Type", fallback=None) if parser.get("Desktop Entry", "GenericName", fallback=None) == None else parser.get("Desktop Entry", "GenericName", fallback=None)

    entry = {
        "name": app_name.title().replace("&", "and"),
        "icon": icon_path,
        "comment": comment.replace("&", "and"),
        "desktop": f"gtk-launch {os.path.basename(file_path)} ",
    }
    return entry

def update_cache(all_apps, preferred_apps):
    data = {"cmd": [],"math": [], "apps": all_apps, "preferred": preferred_apps}
    with open(jsonPath, "w") as file:
        json.dump(data, file, indent=2)

def get_cached_entries():
    if os.path.exists(jsonPath):
        with open(jsonPath, "r") as file:
            try:
                return json.load(file)
            except json.JSONDecodeError:
                pass

    all_apps = []
    preferred_apps = []


    for file_path in desktop_files:
        entry = get_desktop_entries(file_path)
        if entry is not None:
            all_apps.append(entry)
            if entry["name"].lower() in PREFERRED_APPS:
                preferred_apps.append(entry)

    # Sort applications alphabetically by name
    all_apps = sorted(all_apps, key=lambda x: x["name"].lower())

    update_cache(all_apps, preferred_apps)
    return {"cmd": [],"math": [], "apps": all_apps, "preferred": preferred_apps}

def filter_entries(entries, query):
    if query:
        query = query.lower()
        filtered_data = []

        for entry in entries["apps"]:
            name = entry["name"].lower()
            comment = entry["comment"].lower() if entry["comment"] else ""

            if any(keyword in name or keyword in comment for keyword in query.split()):
                entry["comment"] = highlight(comment, query) if comment else ""

                filtered_data.append(entry)

        return filtered_data
    else:
        for entry in entries["apps"]:
            entry["name"] = entry["name"].title()
            entry["comment"] = entry["comment"]
        return entries["apps"]

def highlight(text, query):
    # Función para resaltar las coincidencias en el texto con Pango Markup
    start_tag = '<span foreground="#8f9091" font-weight="900">'
    end_tag = '</span>'

    for keyword in query.split():
        text = text.replace(keyword, f"{start_tag}{keyword}{end_tag}")
    return text


def math(query):
    try:
        result = eval(query)
        temp = ''.join([f" {i} " if i in "+-*/" else i for i in query])

        dict = {
        "name": "Calculator",
        "icon": get_gtk_icon("accessories-calculator"),
        "comment": f"{temp} = {result}",
        "desktop": f"echo '{result}' | wl-copy && notify-send -i 'accessories-calculator' -a 'Calculator' 'Copied to  Clipboard' '{result}'"
        }
        return [dict]
    except:
        return []

def cmdApp(content):
    if content.startswith("/"):
        dict = {
            "name": "Run a Command",
            "icon": get_gtk_icon("gnome-term"),
            "comment": content,
            "desktop": f"{content[1:]}",
        }
        return [dict]
    else:
        return []

def update_eww(entries):
    shellRun(["eww", "update", f"apps={json.dumps(entries)}"])

if __name__ == "__main__":
    entries = get_cached_entries()
    query = sys.argv[2] if len(sys.argv) > 2 and sys.argv[1] == "--query" else None

    if query is not None:
        math = math(query)
        cmd = cmdApp(query)

        if math or cmd:
            filtered = filter_entries(entries, False)
            update_eww({"cmd": cmd, "math": math,"apps": filtered, "preferred": entries["preferred"]})

        else:
            filtered = filter_entries(entries, query)
            update_eww({"cmd": cmd, "math": math,"apps": filtered, "preferred": entries["preferred"]})


    else:
        update_eww(entries)
