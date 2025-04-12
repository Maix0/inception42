# as of writing latest is 3.21
FROM alpine:3.20

# install tools
RUN apk add wget fcgi;

# install php stuff
RUN apk add php82 php82-cgi php82-ctype php82-fpm php82-gd php82-iconv php82-mbstring php82-mysqli php82-openssl php82-phar php82-redis php82-tokenizer mariadb-client;

COPY ./www.conf /etc/php82/php-fpm.conf

RUN \
	wget -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /tmp/adminer.php && \
	mkdir -p /var/www/html && \
	mv /tmp/adminer.php /var/www/html/index.php && \
	adduser www-data -D -G www-data --disabled-password --system;


STOPSIGNAL SIGQUIT

CMD [ "/usr/sbin/php-fpm82" ]

