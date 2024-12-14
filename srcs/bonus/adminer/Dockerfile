# as of writing latest is 3.21
FROM alpine:3.20

# install tools
RUN apk add wget;
RUN apk add fcgi;

# install php stuff
RUN apk add php82;
RUN apk add php82-cgi;
RUN apk add php82-ctype;
RUN apk add php82-fpm;
RUN apk add php82-gd;
RUN apk add php82-iconv;
RUN apk add php82-mbstring;
RUN apk add php82-mysqli;
RUN apk add php82-openssl;
RUN apk add php82-phar;
RUN apk add php82-redis;
RUN apk add php82-tokenizer;
RUN apk add mariadb-client;

COPY ./www.conf /etc/php82/php-fpm.conf

RUN \
	wget -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /tmp/adminer.php && \
	mkdir -p /var/www/html && \
	mv /tmp/adminer.php /var/www/html/index.php && \
	adduser www-data -D -G www-data --disabled-password --system;


STOPSIGNAL SIGQUIT

CMD [ "/usr/sbin/php-fpm82" ]

