# as of writing latest is 3.21
FROM alpine:3.20

# install tools
RUN apk add wget;
RUN apk add curl;
RUN apk add fcgi;

# install php stuff
RUN apk add php82;
RUN apk add php82-cgi;
RUN apk add php82-fpm;
RUN apk add php82-phar;
RUN apk add php82-openssl;
RUN apk add php82-mysqli;
RUN apk add php82-iconv;
run apk add mariadb-client;

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

#We expose the 9000 port
EXPOSE 9000

CMD ["/bin/wp_conf", "/usr/sbin/php-fpm82"]
