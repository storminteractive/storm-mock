FROM nginx:alpine

RUN apk add nodejs-current-npm
RUN npm install -g json-server

WORKDIR /
COPY entrypoint.sh .

#ENTRYPOINT ["/usr/bin/json-server /db.json"]
ENTRYPOINT ["/entrypoint.sh"]
#ENTRYPOINT ["/bin/sh"]
