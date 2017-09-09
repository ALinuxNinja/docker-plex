FROM ubuntu:16.04

## Add docker scripts
ADD scripts /scripts

## Set WORKDIR
WORKDIR /tmp

RUN apt-get update \
	&& apt-get install -y curl augeas-tools augeas-lenses python3 \
	&& rm -rf /var/lib/apt/lists/*
	&& ln -s /bin/true /sbin/udevadm \
	&& curl -L $(/scripts/plex_getlink.py) > plexmediaserver.deb \
	&& dpkg -i plexmediaserver.deb \
	&& rm plexmediaserver.deb \
	&& usermod -u 1000 plex \
	&& groupmod -g 1000 plex

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]

## Expose port
EXPOSE 32400
