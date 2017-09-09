FROM ubuntu:16.04

## Add docker scripts
ADD scripts /scripts

## Set URL
ARG PLEX_DL

## Set WORKDIR
WORKDIR /tmp

RUN apt-get update \
	&& apt-get install -y curl augeas-tools augeas-lenses \
	&& rm -rf /var/lib/apt/lists/*
	&& ln -s /bin/true /sbin/udevadm \
	&& curl -L ${PLEX_DL} > plexmediaserver.deb \
	&& dpkg -i plexmediaserver.deb \
	&& rm plexmediaserver.deb \
	&& usermod -u 1000 plex \
	&& groupmod -g 1000 plex

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]

## Expose port
EXPOSE 32400
