# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init_mariadb.sh                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sojetimi <sojetimi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/24 20:22:53 by sojetimi          #+#    #+#              #
#    Updated: 2026/06/26 22:12:59 by sojetimi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld_safe --datadir=/var/lib/mysql --bind-address=0.0.0.0 &

until mysqladmin ping --silent; do
	sleep 1
done

if [ ! -f "/var/lib/mysql/.inception_initialized" ]; then
	mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	touch /var/lib/mysql/.inception_initialized
fi

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec mysqld_safe --datadir=/var/lib/mysql --bind-address=0.0.0.0