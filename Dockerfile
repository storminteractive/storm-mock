FROM nginx:alpine

RUN apk add nodejs-current-npm nano
RUN npm install -g json-server

WORKDIR /
COPY entrypoint.sh .


COPY app/. /app/

WORKDIR /app
RUN npm install 

ENTRYPOINT ["/entrypoint.sh"]
#ENTRYPOINT ["sh"]
