FROM ubuntu:16.04

## Add docker scripts
ADD scripts /scripts

## Set WORKDIR
WORKDIR /tmp

## Installer URL
ARG PLEX_DL

RUN apt-get update \
	&& apt-get install --no-install-recommends -y augeas-tools augeas-lenses curl \
	&& ln -s /bin/true /sbin/udevadm \
	&& curl -L ${PLEX_DL} > plexmediaserver.deb \
	&& dpkg -i plexmediaserver.deb \
	&& rm plexmediaserver.deb \
	&& usermod -u 1000 plex \
	&& groupmod -g 1000 plex \
	&& apt-get -y purge curl \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]

## Expose port
EXPOSE 32400
