#!/bin/bash

VER=latest
CONTAINERNAME=storm-mock
IMAGENAME=storminteractive/storm-mock:$VER

docker kill $CONTAINERNAME; docker rm $CONTAINERNAME;

docker run --name $CONTAINERNAME --restart=unless-stopped \
  -v $(pwd)/db.json:/db.json \
  --hostname app1.stormint.com \
  --network host \
  -dit $IMAGENAME

#  -v $(pwd)/proxies.cfg:/proxies.cfg \
#  -e PROXIES='bin.app1.stormint.com,http://localhost:1001' \

docker logs -f $CONTAINERNAME
