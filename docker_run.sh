#!/bin/bash
# Sample run script.  Primarly used in build / testing

docker rm kf2
docker run -it -p 7777:7777/udp -p 27015:27015/udp -p 8080:8080/tcp -p 20560:20560/tcp -v /app/docker/temp-vol:/app \
-e MAP="KF-BurningParis" \
-e ADMIN="antimodes201" \
-e PASSWORD="91f1c88adf" \
--name kf2 \
antimodes201/kf2-server:build
