FROM ubuntu:16.04

## Add docker scripts
ADD scripts /scripts

## Set WORKDIR
WORKDIR /tmp

## Add installer
ADD plexmediaserver.deb plexmediaserver.deb

RUN apt-get update \
	&& apt-get install --no-install-recommends -y augeas-tools augeas-lenses \
	&& rm -rf /var/lib/apt/lists/* \
	&& ln -s /bin/true /sbin/udevadm \
	&& dpkg -i plexmediaserver.deb \
	&& rm plexmediaserver.deb \
	&& usermod -u 1000 plex \
	&& groupmod -g 1000 plex

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]

## Expose port
EXPOSE 32400
