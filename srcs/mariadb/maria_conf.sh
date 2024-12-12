#!/bin/sh

set -e
set -x

chown mysql -R /var/lib/mysql;
/usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql;
su mysql -s /bin/sh -c mysqld &
PID=$!

mysqladmin status --wait

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS'; FLUSH PRIVILEGES;" | mysql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" | mysql
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME; GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS'; FLUSH PRIVILEGES;" | mysql

# shutdown temp daemon and wait for it to actually shutdown
su mysql -s /bin/sh -c "mysqladmin shutdown"
wait "$PID"

# configure mariadb to use port 3307
sed -i /etc/my.cnf.d/mariadb-server.cnf -e 's/^port=3307$/\0\nbind-address = 0.0.0.0/'
sed -i /etc/my.cnf.d/mariadb-server.cnf -e 's/^skip-networking$/;\0/'

exec su mysql -s /bin/sh -c "$@"
