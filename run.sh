#!/bin/sh

docker run --name 1c-server \
  --net host \
  --detach \
  --volume 1c-server-home:/home/usr1cv8 \
  --volume 1c-server-logs:/var/log/1C \
  --volume /etc/localtime:/etc/localtime:ro \
  vagurko/docker-1c-ss:8.3.25-1394
