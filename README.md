# docker-plex
Runs Plex Media Server in a docker container
  - Sets up latest Plex Media Server
  - Support for configuring Plex Media Server using ENV variables
  - Configuration using augeas (augtool)

## Configuration
ENV Variables are used to configure the default preferences. To set the value of a preference, retrieve the preference name from https://support.plex.tv/hc/en-us/articles/201105343-Advanced-Server-Settings . Then, set env variable to `PLEX_<Preference Name>`, with the value being the desired value of the preference.

## Ports and Volumes
See https://support.plex.tv/hc/en-us/articles/201543147-What-network-ports-do-I-need-to-allow-through-my-firewall- for the ports that need to be mapped. The Plex preferences are stored at /var/lib/plexmediaserver, so it may be desireable to mount that as a volume.

Media can be mounted as a secondary volume as long as permissions are correct.

### Example Configuration (docker-compose.yml)
```
sys:
  container_name: plexmediaserver
  build: .
  restart: always
  tty: true
  environment:
    - PLEX_allowedNetworks="0.0.0.0/0.0.0.0"
  volumes:
    - data:/var/lib/plexmediaserver
    - media:/media
  ports:
    - 32400:32400
```
