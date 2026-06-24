# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init_wordpress.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sojetimi <sojetimi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/24 20:43:29 by sojetimi          #+#    #+#              #
#    Updated: 2026/06/24 20:43:32 by sojetimi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

set -e

cd /var/www/html

if [ ! -f /usr/local/bin/wp ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f /var/www/html/wp-config.php ]; then
	rm -rf /var/www/html/*
	wp core download --allow-root

	wp config create \
		--dbname="${MYSQL_DATABASE}" \
		--dbuser="${MYSQL_USER}" \
		--dbpass="${MYSQL_PASSWORD}" \
		--dbhost="mariadb:3306" \
		--allow-root
fi

until mysqladmin ping -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent; do
	echo "Waiting for MariaDB..."
	sleep 2
done

if ! wp core is-installed --allow-root; then
	wp core install \
		--url="https://${DOMAIN_NAME}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--skip-email \
		--allow-root

	wp user create \
		"${WP_USER}" \
		"${WP_USER_EMAIL}" \
		--user_pass="${WP_USER_PASSWORD}" \
		--role=author \
		--allow-root
fi

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php

exec php-fpm7.4 -F