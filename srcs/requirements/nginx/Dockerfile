# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sojetimi <sojetimi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/24 20:18:30 by sojetimi          #+#    #+#              #
#    Updated: 2026/06/24 20:46:30 by sojetimi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt update && apt install -y nginx openssl && rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/init_nginx.sh /init_nginx.sh

RUN chmod +x /init_nginx.sh

EXPOSE 443

CMD ["/init_nginx.sh"]