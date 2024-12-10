# as of writing latest is 3.21
FROM alpine:3.20

# install tools
RUN apk add wget;
RUN apk add fcgi;

# install php stuff
RUN apk add php82-cgi;
RUN apk add php82-fpm;

# adding wordpress user
RUN mkdir -p /var/www/html;
RUN adduser -D -g 'wordpress' wordpress;

# Dowloading wordpress files and configuring wordpress
RUN wp core download --path=/var/www/html --locale=en_US --allow-root;
RUN wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost=mariadb --allow-root;
RUN wp core install \
	--url="$WP_URL" --title="$WP_TITLE" \
	--admin_user="$WP_AUSER" --admin_password="$WP_APASS" --admin_email="$WP_AMAIL" --allow-root;
RUN wp theme activate twentytwentytwo  --allow-root;
RUN wp user create "$WP_USER" "$WP_MAIL" --user_pass="$WP_PASS" --role=editor --allow-root;
RUN wp option set comment_previously_approved 0 --allow-root;

#for the bonus, will see later

#RUN wp config set WP_REDIS_HOST redis --allow-root;
#RUN wp config set WP_REDIS_PORT 6379 --allow-root;
#RUN wp config set WP_REDIS_DATABASE 0 --allow-root;
#RUN wp config set WP_CACHE true --allow-root;
#RUN wp plugin update --all --allow-root;
#RUN wp plugin install redis-cache --activate --allow-root;
#RUN wp redis enable --allow-root;


RUN chown wordpress -R /var/www/html;

# Copy the .conf in the html directory
COPY ./www.conf /etc/php/8.2/fpm/pool.d/

# installing wp cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /bin/wp;
RUN chmod +x /bin/wp;

#We expose the 9000 port
EXPOSE 9000

CMD ["/usr/sbin/php-fpm82", "-F"]
