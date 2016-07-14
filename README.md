# docker-plex

Plex for Docker aims at being an easy to use container that is ready to deploy immediately.

It currently installs the lastest version of Plex Media Server, and supports the configuration of all Plex Media Server preferences listed on [Advanced Server Settings](https://support.plex.tv/hc/en-us/articles/201105343-Advanced-Server-Settings)

## Getting started

To begin running Plex for Docker, ensure that [docker](https://docs.docker.com/engine/installation/) and [docker-compose](https://docs.docker.com/compose/install/) are installed on the target machine.

Then, clone the repo with git to a folder of your liking:
```
git clone https://github.com/ALinuxNinja/docker-plex.git
```
and begin running Plex for Docker
```
cd docker-plex
docker-compose up -d
```
Docker can then be accessed at http://127.0.0.1:32400, as well as other IP Addresses avaliable on your machine.

To add media, create seperate folders in the "media" folder for your different types of content such as "Movies" and "TV Shows".
Files must be organized based on the conventions in [Media Preperation](https://support.plex.tv/hc/en-us/categories/200028098-Media-Preparation).

Then, open Plex, and there you can add the folders in "/media" to your media library.

## Additional Configuration
ENV Variables are used to configure the preferences listed on the [Advanced Server Settings](https://support.plex.tv/hc/en-us/articles/201105343-Advanced-Server-Settings) page.

To set the value of a preference, retrieve the name of the preference from the link to the page above.

Then, set the name of the ENV  variable to `PLEX_<Preference Name>`, with the value being the desired value of the preference. For example, the env variable `PLEX_DlnaEnabled` allows for the DLNA service to be enabled or disabled.

An example of how to set the ENV variable in a docker container is provided in docker-compose.yml.

## Ports and Volumes
See https://support.plex.tv/hc/en-us/articles/201543147-What-network-ports-do-I-need-to-allow-through-my-firewall- for the ports that need to be mapped. The primary required port (32400 TCP) is already mapped for you.

The Plex preferences are stored at /var/lib/plexmediaserver, and it is mounted the "data" folder.

## Upgrading
There is no special configuration required for upgrading.

## Misc Notes
 -  There is a .dockerignore file to ignore both "data" and "media" so that docker does not add them to docker builds.

### Example Configuration (docker-compose.yml)
```
sys:
  container_name: plexmediaserver
  build: .
  restart: always
  tty: true
  environment:
    - PLEX_DlnaEnabled="1"
  volumes:
    - data:/var/lib/plexmediaserver
    - media:/media
  ports:
    - 32400:32400
```
