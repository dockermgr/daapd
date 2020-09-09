#!/usr/bin/env bash

mkdir -p /srv/docker/daapd/{etc,music} && chmod -Rf 777 /srv/docker/daapd

docker run -d \
--name=daapd \
--hostname daapd \
--net=host \
-v /srv/docker/daapd/etc:/config \
-v /srv/docker/music:/music \
registry.casjay.in/latest/daapd:latest
