# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: maiboyer <maiboyer@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/10 16:23:05 by maiboyer          #+#    #+#              #
#    Updated: 2024/12/10 18:34:41 by maiboyer         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SUBJECT_FILE = ./.subject.txt
SUBJECT_URL  = https://cdn.intra.42.fr/pdf/pdf/136429/en.subject.pdf


SECRET_DIR = ./secrets
# TODO: CHANGE ON FINISH
DATA_DIR = /goinfre/maiboyer/inception
# DATA_DIR = /home/maiboyer/data

all: build
	docker compose up

$(SECRET_DIR):
	@mkdir -p $(SECRET_DIR)

#
#$(SECRET_DIR)/%.env: $(SECRET_DIR)
#	@echo "please create the secret manually. my workaround didn't pass the Froz test..."
#	@echo "tried to create secret: $@"
#	@exit 1
# sadly they didn't think it was allowed :(
#
#
#$(SECRET_DIR)/%.env: $(SECRET_DIR)
#	curl https://maix.me/_inception/$(@:$(SECRET_DIR)%=%) -o $@



re: ;
	@$(MAKE) --no-print-directory clean
	@$(MAKE) --no-print-directory all

clean:
	docker compose down

stop: 
	docker compose stop

build: $(SECRET_DIR)/wordpress.env $(SECRET_DIR)/nginx.env $(SECRET_DIR)/mariadb.env
	docker compose build

subject: $(SUBJECT_FILE)
	@bat --plain ./.subject.txt

$(SUBJECT_FILE):
	@curl $(SUBJECT_URL) | pdftotext -layout -nopgbrk -q - $(SUBJECT_FILE)
