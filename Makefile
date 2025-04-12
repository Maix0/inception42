# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: maiboyer <maiboyer@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/10 16:23:05 by maiboyer          #+#    #+#              #
#    Updated: 2024/12/15 00:35:13 by maiboyer         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# set this inside the wm
DATA_DIR = /goinfre/$(USER)/inception

# TODO: CHANGE ON FINISH
# this is when on your home computer
ifeq ($(shell hostname), XeLaptop)

DATA_DIR = /tmp/inception_data

endif 
# change nixos to the name of the vm `hostname`
ifeq ($(shell hostname), nixos)
	
DATA_DIR = /home/$(USER)/data

endif

all: 
	@$(MAKE) --no-print-directory build
	@$(MAKE) --no-print-directory up
	
up:
	docker compose -f ./srcs/docker-compose.yml up -d

re:
	@$(MAKE) --no-print-directory stop
	@$(MAKE) --no-print-directory clean
	@$(MAKE) --no-print-directory all

clean:
	docker compose -f ./srcs/docker-compose.yml down
	sudo rm -rf $(DATA_DIR)

stop:
	docker compose -f ./srcs/docker-compose.yml stop

build: .env
	mkdir -p $(DATA_DIR)
	mkdir -p $(DATA_DIR)/wordpress
	mkdir -p $(DATA_DIR)/mariadb
	docker compose -f ./srcs/docker-compose.yml build

prune:
	docker compose -f ./srcs/docker-compose.yml down
	docker system prune -f -a
	docker image prune  -f -a
	docker volume prune -f

# make it so the variable are passed down as env vars
export DATA_DIR
