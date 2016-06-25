#!/usr/bin/env python2
import urllib2
import sys
import json

json_downloads = urllib2.urlopen('https://plex.tv/api/downloads/1.json')
json_data = json.loads(json_downloads.read())

for distro in json_data["computer"]["Linux"]["releases"]:
        if distro["build"] == "linux-ubuntu-x86_64" and distro["distro"] == "ubuntu":
                print distro["url"]
