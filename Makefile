.PHONY: help     # Generate list of targets with descriptions
help:
	@echo "\n"
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1 \2/' | expand -t20


.PHONY: build    # Builds Docker images
build:
	docker-compose -f docker/docker-compose.yml build

.PHONY: up       # Creates container for each service: php, nginx, and ..
up:
	docker-compose -f docker/docker-compose.yml up -d

.PHONY: down     # It shuts down the running containers
down:
	docker-compose -f docker/docker-compose.yml down

.PHONY: php      # Enters the PHP Container
php:
	docker-compose -f docker/docker-compose.yml exec php bash

.PHONY: nginx    # Enters the NGINX Container
nginx:
	docker-compose -f docker/docker-compose.yml exec nginx bash

.PHONY: mysql    # Enters the MySQL Container
mysql:
	docker-compose -f docker/docker-compose.yml exec mysql bash


.PHONY: mongo    # Enters the MongoDB Container
mongo:
	docker-compose -f docker/docker-compose.yml exec mongo bash

.PHONY: redis    # Enters the Redis Container
redis:
	docker-compose -f docker/docker-compose.yml exec redis bash

