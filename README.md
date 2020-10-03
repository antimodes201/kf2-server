# kf2-server
Docker container for a Killing Floor 2 Server

Build to create a containerized version of the dedicated server for Killing Floor 2
https://store.steampowered.com/agecheck/app/232090/
 
 
Build by hand
```
git clone https://github.com/antimodes201/kf2-server.git
docker build -t antimodes201/kf2-server:latest .
``` 
 
Docker Pull
```
docker pull antimodes201/kf2-server
```
 
Docker Run with defaults 
change the volume options to a directory on your node and maybe use a admin and password then the one in the example
 
```
docker run -it -p 7777:7777/udp -p 27015:27015/udp -p 8080:8080/tcp -p 20560:20560/tcp -v /app/docker/temp-vol:/app \
-e ADMIN="admin" \
-e PASSWORD="CHANGEME" \
--name kf2 \
antimodes201/kf2-server:latest
```
 
If you would like to use a different starting map besides Paris then you can add the map environment variable.
```
docker run -it -p 7777:7777/udp -p 27015:27015/udp -p 8080:8080/tcp -p 20560:20560/tcp -v /app/docker/temp-vol:/app \
-e ADMIN="admin" \
-e PASSWORD="CHANGEME" \
-e MAP="KF-BurningParis" \
--name kf2 \
antimodes201/kf2-server:latest
```
 
Additional launch arguments can be used to further modify the server at run time.  These are broken into launch arguments that start with - and launch options that start with a ?.
Example to use a customer set of configs that is found in KFGame/Config/MYCONFIGS
```
docker run -it -p 7777:7777/udp -p 27015:27015/udp -p 8080:8080/tcp -p 20560:20560/tcp -v /app/docker/temp-vol:/app \
-e ADMIN="admin" \
-e PASSWORD="CHANGEME" \
-e MAP="KF-BurningParis" \
-e ADDITIONAL_OPTS="?ConfigSubDir=MYCONFIGS" \
--name kf2 \
antimodes201/kf2-server:latest
```

  
Currently exposed environmental variables and their default values
- GAME_PORT 7777
- QUERY_PORT 27015
- WEB_ADMIN 8080
- STEAM_PORT 20560
- MAP BurningParis
- TZ America/New_York

  
Additional configurations can be changed through ini edits or the webconsole once the container has been run once.  Please reference https://wiki.killingfloor2.com/index.php?title=Dedicated_Server_(Killing_Floor_2)#Advanced_Configuration for additional setup options.