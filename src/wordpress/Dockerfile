# as of writing latest is 3.21
FROM alpine:3.20
RUN apk add wget;
RUN apk add php82-fpm;

RUN mkdir -p /run/wordpress;
RUN adduser -D -g 'wordpress' wordpress;

RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz;
RUN tar -xzvf /tmp/wordpress.tar.gz -C /run/wordpress;
RUN rm /tmp/wordpress.tar.gz;
RUN chown wordpress -R /run/wordpress;

CMD ["/usr/sbin/php-fpm82", "-F"]
