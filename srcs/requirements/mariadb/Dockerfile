# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sojetimi <sojetimi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/24 20:35:06 by sojetimi          #+#    #+#              #
#    Updated: 2026/06/24 20:35:09 by sojetimi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt update && apt install -y mariadb-server && rm -rf /var/lib/apt/lists/*

COPY ./tools/init_mariadb.sh /init_mariadb.sh

RUN chmod +x /init_mariadb.sh

EXPOSE 3306

CMD ["/init_mariadb.sh"]