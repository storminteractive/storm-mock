FROM nginx:alpine

RUN apk add nodejs-current-npm nano
RUN npm install -g json-server

WORKDIR /
COPY entrypoint.sh .
COPY app/* app/

WORKDIR /app
RUN npm install 

#COPY db.json .

ENTRYPOINT ["/entrypoint.sh"]
#ENTRYPOINT ["sh"]
