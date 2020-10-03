FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

ARG GAME_PORT=7777
ARG QUERY_PORT=27015
ARG WEB_ADMIN=8080
ARG STEAM_PORT=20560 

# Set some Variables
ENV GAME_PORT $GAME_PORT
ENV GAME_PORT2 $GAME_PORT2
ENV QUERY_PORT $QUERY_PORT
ENV WEB_ADMIN $WEB_ADMIN
ENV STEAM_PORT $STEAM_PORT
ENV ADMIN "Admin"
ENV PASSWORD "CHANGEME"
ENV MAP "KF-BurningParis"
ENV ADDITIONAL_OPTS ""
ENV ADDITIONAL_ARGS ""
ENV TZ "America/New_York"

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
		libcurl3  \
		lib32gcc1 \
		wget \
		unzip \
		tzdata \
		ca-certificates && \
		rm -rf /var/lib/apt/lists/*

# create directories
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steamuser && \
    usermod -G tty steamuser \
        && mkdir -p /app \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /app \
		&& chown steamuser:steamuser /scripts 

# Install Steamcmd 
# depreciated.  Moved into start script
USER steamuser

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE $GAME_PORT/udp
EXPOSE $QUERY_PORT/udp
EXPOSE $WEB_ADMIN/tcp
EXPOSE $STEAM_PORT/UDP

# Make a volume
# contains configs and world saves
VOLUME /app

CMD ["/scripts/start.sh"]
