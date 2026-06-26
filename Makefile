COMPOSE = docker compose -f srcs/docker-compose.yml

DATA_DIR = /home/$(USER)/data
WP_DATA = $(DATA_DIR)/wordpress
DB_DATA = $(DATA_DIR)/mariadb

all:
	mkdir -p $(WP_DATA)
	mkdir -p $(DB_DATA)
	$(COMPOSE) up --build -d

up: all

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

restart:
	$(COMPOSE) restart

logs:
	$(COMPOSE) logs

ps:
	$(COMPOSE) ps

clean:
	$(COMPOSE) down -v

fclean: clean
	docker system prune -af
	sudo rm -rf $(DATA_DIR)

re: fclean all

.PHONY: all up down stop start restart logs ps clean fclean re