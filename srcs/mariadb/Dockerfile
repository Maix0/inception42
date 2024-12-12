# as of writing latest is 3.21
FROM alpine:3.20

#installing mariadb and a client to configure stuff
RUN apk add mariadb;
RUN apk add mariadb-client;

RUN mkdir -p /var/lib/mysql;
RUN mkdir -p /run/mysqld;
RUN chown mysql -R /run/mysqld;
COPY ./maria_conf.sh /bin/maria_conf
RUN chmod +x /bin/maria_conf;

EXPOSE 3306

CMD ["/bin/maria_conf", "mysqld"]

