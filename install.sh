#!/usr/bin/env bash

APPNAME="daapd"
DOCKER_HUB_URL="linuxserver/daapd"

sudo mkdir -p "$DATADIR"/{config,music}
sudo chmod -Rf 777 "$DATADIR"

if docker ps -a | grep "$APPNAME" >/dev/null 2>&1; then
  sudo docker pull "$DOCKER_HUB_URL"
  sudo docker restart "$APPNAME"
else
  sudo docker run -d \
    --name="$APPNAME" \
    --hostname "$APPNAME" \
    --net=host \
    -e TZ=America/New_York \
    -v "$DATADIR/config":/config \
    -v "$DATADIR/music":/music \
    "$DOCKER_HUB_URL"
fi
