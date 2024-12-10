# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: maiboyer <maiboyer@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/10 16:23:05 by maiboyer          #+#    #+#              #
#    Updated: 2024/12/10 23:18:09 by maiboyer         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SUBJECT_FILE = ./.subject.txt
SUBJECT_URL  = https://cdn.intra.42.fr/pdf/pdf/136429/en.subject.pdf


SECRET_DIR = ./secrets
# TODO: CHANGE ON FINISH
DATA_DIR = /goinfre/maiboyer/inception
# DATA_DIR = /home/maiboyer/data

all: build
	docker compose -f ./srcs/docker-compose.yml up -d 
re: ;
	@$(MAKE) --no-print-directory clean 
	@$(MAKE) --no-print-directory all

clean:
	docker compose -f ./srcs/docker-compose.yml down

stop: 
	docker compose -f ./srcs/docker-compose.yml stop

build: $(SECRET_DIR)/wordpress.env $(SECRET_DIR)/nginx.env $(SECRET_DIR)/mariadb.env
	docker compose -f ./srcs/docker-compose.yml build

subject: $(SUBJECT_FILE)
	@bat --plain ./.subject.txt

$(SUBJECT_FILE):
	@curl $(SUBJECT_URL) | pdftotext -layout -nopgbrk -q - $(SUBJECT_FILE)

prune:
	docker compose down
	docker system prune
	docker image prune
	docker volume prune

secret:
	-rm -r $(SECRET_DIR)
	cp -r ./secrets.template/ $(SECRET_DIR)
	@./fill_secrets.sh mariadb   "DB_NAME"  "Database name"
	@./fill_secrets.sh mariadb   "DB_USER"  "Database username"
	@./fill_secrets.sh mariadb   "DB_PASS"  "Database password" fill_value
	@./fill_secrets.sh wordpress "WP_URL"   "Wordpress url"
	@./fill_secrets.sh wordpress "WP_TITLE" "Wordpress title"
	@./fill_secrets.sh wordpress "WP_AUSER" "Wordpress admin username"
	@./fill_secrets.sh wordpress "WP_APASS" "Wordpress admin password" fill_value
	@./fill_secrets.sh wordpress "WP_AMAIL" "Wordpress admin email"
	@./fill_secrets.sh wordpress "WP_USER"  "Wordpress normal username"
	@./fill_secrets.sh wordpress "WP_PASS"  "Wordpress normal password" fill_value
	@./fill_secrets.sh wordpress "WP_MAIL"  "Wordpress normal email"

.PHONY: secret

# make it so the variable are passed down as env vars
export DATA_DIR SECRET_DIR
