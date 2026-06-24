# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sojetimi <sojetimi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/24 20:42:56 by sojetimi          #+#    #+#              #
#    Updated: 2026/06/24 20:42:59 by sojetimi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt update && apt install -y \
	php7.4 \
	php7.4-fpm \
	php7.4-mysql \
	mariadb-client \
	curl \
	wget \
	tar \
	less \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

COPY ./tools/init_wordpress.sh /init_wordpress.sh

RUN chmod +x /init_wordpress.sh

EXPOSE 9000

CMD ["/init_wordpress.sh"]