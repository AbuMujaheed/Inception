# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init_nginx.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sojetimi <sojetimi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/24 20:13:07 by sojetimi          #+#    #+#              #
#    Updated: 2026/06/24 20:46:59 by sojetimi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


set -e

mkdir -p /etc/ssl/private
mkdir -p /etc/ssl/certs

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
	openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 \
		-keyout /etc/ssl/private/nginx.key \
		-out /etc/ssl/certs/nginx.crt \
		-subj "/C=CZ/ST=Prague/L=Prague/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

exec nginx -g "daemon off;"