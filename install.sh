#!/usr/bin/env bash

APPNAME="daapd"
DATADIR="/srv/docker/$APPNAME"

mkdir -p "$DATADIR"/{config,music} && chmod -Rf 777 "$DATADIR"

if docker ps -a | grep "$APPNAME" >/dev/null 2>&1; then
docker pull linuxserver/daapd && docker restart $APPNAME
else
docker run -d \
--name="$APPNAME" \
--hostname "$APPNAME" \
--net=host \
-e TZ=America/New_York \
-v $DATADIR/config:/config \
-v $DATADIR/music:/music \
linuxserver/daapd
