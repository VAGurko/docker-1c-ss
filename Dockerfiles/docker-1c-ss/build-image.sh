#!/bin/bash
ARH=arm64
PLATFORM=8.3.25
RELEASE=1394

docker build --tag vagurko/docker-1c-ss:${ARH}_${PLATFORM}-${RELEASE} .
docker login
docker push vagurko/docker-1c-ss:${ARH}_${PLATFORM}-${RELEASE}
