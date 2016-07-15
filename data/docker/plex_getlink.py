#!/usr/bin/env python3
from urllib.request import urlopen
import sys
import json

json_downloads = urlopen('https://plex.tv/api/downloads/1.json').readall().decode('utf-8')
json_data = json.loads(json_downloads)

for distro in json_data["computer"]["Linux"]["releases"]:
        if distro["build"] == "linux-ubuntu-x86_64" and distro["distro"] == "ubuntu":
                print (distro["url"])
