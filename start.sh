#!/bin/bash -ex
# Start script for Killing Floor 2 called from docker

# Move steamcmd install to startup
if [ ! -f /app/steamcmd/steamcmd.sh ]
then
	# no steamcmd
	printf "SteamCMD not found, installing\n"
	mkdir /app/steamcmd/
	cd /app/steamcmd/
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf steamcmd_linux.tar.gz
	rm steamcmd_linux.tar.gz
fi

# check for updates
/app/steamcmd/steamcmd.sh +login anonymous +force_install_dir /app +app_update 232130 +quit
	
# server cache fix
if [ ! -f  /app/KFGame/Cache ]
then
	mkdir -p /app/KFGame/Cache
fi


# Launch Server
# Variables pulled from Docker environment
cd /app/Binaries/Win64/
/app/Binaries/Win64/KFGameSteamServer.bin.x86_64 ${MAP}?Port=${GAME_PORT}?QueryPort=${QUERY_PORT}?WebAdminPort=${WEB_ADMIN}?AdminName=${ADMIN}?AdminPassword=${PASSWORD}${ADDITIONAL_OPTS} ${ADDITIONAL_ARGS}
