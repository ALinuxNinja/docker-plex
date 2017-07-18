#!/bin/bash

## Fix permissions on plex folders
chown -R plex:plex /var/lib/plexmediaserver 2> /dev/null

## Start/Stop Plex Media Server to generate required IDs if running for first time
if [ ! -f "/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml" ]; then

	## Start Plex Media Server in background
	/sbin/setuser plex /usr/sbin/start_pms &
	
	## Wait for configuration to be generated
	while [[ ! -f "/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml" && $(grep -i machineidentifier "/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml" 2>/dev/null) == "" && $(grep -i processedmachineidentifier "/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml" 2>/dev/null) == "" && $(grep -i anonymousmachineidentifier "/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml" 2>/dev/null) == ""  ]]
	do
		sleep 1
	done
	## Stop Plex Media Server
	sleep 10
	kill $(ps ax | grep -v grep | grep -i "Plex Media Server" | awk -F " " '{ print $1 }')
fi
## Copy over pre-configured augtool setup
cp /scripts/augtool /tmp/augtool

## Retrieve all PLEX_* environment variables
env | grep PLEX | awk -F 'PLEX_' '{print $2}' | awk -F '=' '{print "set "$1 " " $2}' >> /tmp/augtool

## Apply settings for Plex Media Server
/tmp/augtool

## Sart up Plex Media Server
su - plex -c "/usr/sbin/start_pms"
