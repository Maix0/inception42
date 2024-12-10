# as of writing latest is 3.21
FROM alpine:3.20

#installing mariadb and a client to configure stuff
RUN apk add mariadb mariadb-client;
RUN mkdir -p /var/lib/mysql;
RUN mkdir -p /run/mysqld;
RUN chown -R mysql /var/lib/mysql;
RUN chown -R mysql /run/mysqld;
RUN /usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql;

CMD ["su", "mysql", "-s", "/bin/sh", "-c", "mysqld"]

