# as of writing latest is 3.21
FROM alpine:3.20

RUN apk add redis;

COPY ./conf_redis.sh /bin/conf_redis
RUN chmod +x /bin/conf_redis

CMD [ "/bin/conf_redis", "redis-server", "--protected-mode", "no" ]
