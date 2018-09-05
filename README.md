[![](https://images.microbadger.com/badges/image/catdeployed/plex:latest.svg)](https://hub.docker.com/r/catdeployed/plex/) [![](https://img.shields.io/microbadger/layers/catdeployed/plex/latest.svg)](https://hub.docker.com/r/catdeployed/plex/)

Plex Media Server for Docker aims at being an easy to use container that is ready to deploy immediately.

It currently installs the lastest version of Plex Media Server, and supports the configuration of all Plex Media Server preferences listed on [Advanced Server Settings](https://support.plex.tv/hc/en-us/articles/201105343-Advanced-Server-Settings)

Builds are done and tagged every day by [CircleCI](https://circleci.com)

## Getting started

To begin running Plex for Docker, ensure that [docker](https://docs.docker.com/engine/installation/) and [docker-compose](https://docs.docker.com/compose/install/) are installed on the target machine.

Then, run git to clone this repo.
```
git clone https://github.com/CatDeployed/docker-plex.git
cd docker-plex
```

Check the settings in `docker-compose.yml` to see if they are what you want. By default, they are set to pretty sane values.

Then, run the following command to bring up Plex Media Server
```
docker-compose up -d
```


## Adding Media

To add media, create seperate folders in the "data/media" folder for your different types of content such as "Movies" and "TV Shows".
Files must be organized based on the conventions in [Media Preparation](https://support.plex.tv/hc/en-us/categories/200028098-Media-Preparation).

Then, open Plex, and there you can add the folders in "/media" to your media library.

## Additional Configuration
ENV Variables are used to configure the preferences listed on the [Advanced Server Settings](https://support.plex.tv/hc/en-us/articles/201105343-Advanced-Server-Settings) page.

To set the value of a preference, retrieve the name of the preference from the link to the page above.

Then, set the name of the ENV  variable to `PLEX_<Preference Name>`, with the value being the desired value of the preference. For example, the docker-compose.yml file sets the env variable `PLEX_DlnaEnabled` to "1", which in turn sets `DlnaEnabled` to "1" in Plex's config file.

```
sys:
  container_name: plexmediaserver
  build: .
  restart: always
  tty: true
  environment:
    - PLEX_DlnaEnabled="1"
  volumes:
    - ./data/Library:/var/lib/plexmediaserver/Library
    - ./data/media:/media
  ports:
    - 32400:32400
```

## Ports and Volumes
See https://support.plex.tv/hc/en-us/articles/201543147-What-network-ports-do-I-need-to-allow-through-my-firewall- for the ports that need to be mapped. The primary required port (32400 TCP) is already mapped for you.

## Upgrading
There is no special configuration required for upgrading. Just pull the container and bring it up again.
```
docker pull catdeployed/plex
docker-compose up -d
```

## Misc Notes
 -  There is a .dockerignore file to ignore the `data` folder.
