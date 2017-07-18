FROM ubuntu:16.04

## Add docker scripts
ADD scripts /scripts

## Set WORKDIR
WORKDIR /tmp

## Get packages
RUN apt-get update && apt-get install -y curl augeas-tools augeas-lenses python3

## Postinstallation script fix
RUN ln -s /bin/true /sbin/udevadm

## Install Plex
RUN curl -L $(/scripts/plex_getlink.py) > plexmediaserver.deb
RUN dpkg -i plexmediaserver.deb
RUN rm plexmediaserver.deb

## Add entrypoint

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]

## Expose port
EXPOSE 32400
