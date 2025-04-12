# as of writing latest is 3.21
FROM alpine:3.20

# install tools
RUN apk add wget fcgi;

# install php stuff
RUN apk add php82 php82-cgi php82-ctype php82-fpm php82-gd php82-iconv php82-mbstring php82-mysqli php82-openssl php82-phar php82-redis php82-tokenizer mariadb-client;

# fix some stuff
RUN ln -s /usr/bin/php82 /bin/php;

# adding wordpress user
RUN adduser -D -g 'wordpress' wordpress;

# installing wp cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /bin/wp-cli.phar;
RUN chmod +x /bin/wp-cli.phar;
RUN ln -s /bin/wp-cli.phar /bin/wp;

# Copy the .conf in the html directory
COPY ./www.conf /etc/php82/php-fpm.conf
COPY ./wp_conf.sh /bin/wp_conf
RUN chmod +x /bin/wp_conf;

STOPSIGNAL SIGQUIT

CMD ["/bin/wp_conf", "/usr/sbin/php-fpm82"]
