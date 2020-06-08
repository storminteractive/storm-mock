#!/bin/bash
VER=latest
IMAGE=storminteractive/storm-mock
IMAGENAME=$IMAGE:$VER
DF=./Dockerfile

#tar -czf scripts.tar.gz scripts/
docker build -t $IMAGENAME . -f $DF
./restart.sh
