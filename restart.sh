#!/bin/bash

VER=latest
CONTAINERNAME=storm-mock
IMAGENAME=storminteractive/storm-mock:$VER

docker kill $CONTAINERNAME; docker rm $CONTAINERNAME;

docker run --name $CONTAINERNAME --restart=unless-stopped \
  -v $(pwd)/db.json:/db.json \
  -p 80:3000 \
  --hostname mock.app1.stormint.com \
  -dit $IMAGENAME \
  --watch db.json


#  --network net1 \
#  --network host \
#  -v $(pwd)/proxies.cfg:/proxies.cfg \
#  -e PROXIES='bin.app1.stormint.com,http://localhost:1001' \

docker logs -f $CONTAINERNAME
