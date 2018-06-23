#!/usr/bin/env python3

## Install and import Packages
import subprocess
import sys
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'requests'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
import requests
import json

json_downloads = requests.get('https://plex.tv/api/downloads/1.json').text.decode('utf-8')
json_data = json.loads(json_downloads)

for distro in json_data["computer"]["Linux"]["releases"]:
        if distro["build"] == "linux-ubuntu-x86_64" and distro["distro"] == "ubuntu":
                print (distro["url"])
