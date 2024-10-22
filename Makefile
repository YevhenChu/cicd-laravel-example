# Makefile for Docker Nginx PHP Composer MySQL

include .env

# MySQL
MYSQL_DUMPS_DIR=data/db/dumps


.DEFAULT_GOAL=help

WWW_USER_ID=${id -u}
PHP_CONTAINER=$(shell docker compose ps -q cicd-php 2> /dev/null)
MYSQL_CONTAINER=$(shell docker compose ps -q cicd-mysqldb 2> /dev/null)

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo "  init 	              Install the project"
	@echo "  start 	      Start the docker containers"
	@echo "  down 	      	      Stop the docker server and remove containers"
	@echo "  build 	      Rebuild the containers"
	@echo "  clean               Clean directories for reset"
	@echo "  composer            Install composer dependencies"
	@echo "  logs                Follow log output"
	@echo "  mysql-dump          Create backup of all databases"
	@echo "  mysql-restore       Restore backup of all databases"
	@echo "  test                Run test suit"

init:
	@make -s build
	@make -s start

laravel-install:
	@docker exec -it ${PHP_CONTAINER} bash -c "composer create-project laravel/laravel ."
	@make -s composer
	rsync --ignore-existing web/.env.example web/.env
	@docker exec -it ${PHP_CONTAINER} bash -c "php artisan key:generate"
	@docker exec -it ${PHP_CONTAINER} bash -c "php artisan migrate:fresh --seed"
	@docker exec -it ${PHP_CONTAINER} bash -c "php artisan storage:link"
	@docker exec -it ${PHP_CONTAINER} bash -c "composer require bschmitt/laravel-amqp"
	@docker exec -it ${PHP_CONTAINER} bash -c "composer require --dev phpstan/phpstan"
	@docker exec -it ${PHP_CONTAINER} bash -c "composer require --dev nunomaduro/larastan"
#	@docker exec -it ${PHP_CONTAINER} bash -c "composer require nunomaduro/phpinsights --dev"
	@docker exec -it ${PHP_CONTAINER} bash -c "composer require --dev friendsofphp/php-cs-fixer"
	@docker exec -it ${PHP_CONTAINER} bash -c "composer require rector/rector --dev"

start:
	@WWW_USER_ID=${WWW_USER_ID} docker compose up --pull missing --remove-orphans -d

down:
	@docker compose down

build:
	@WWW_USER_ID=${WWW_USER_ID} docker compose --profile test build --parallel


clean:
	@rm -Rf data/db/mysql/*
	@rm -Rf $(MYSQL_DUMPS_DIR)/*
	@rm -Rf web/app/vendor
	@rm -Rf web/app/composer.lock
	@rm -Rf web/app/doc
	@rm -Rf web/app/reports
	@rm -Rf etc/ssl/*

composer:
	@docker exec -it ${PHP_CONTAINER} bash -c "composer install"

logs:
	@docker-compose logs -f

test:
	@docker compose exec php bash -c "php artisan view:clear"
	@docker compose run php bash -c "composer test"

test-coverage:
	@docker compose exec php bash -c "php artisan view:clear"
	@docker compose run php bash -c "composer test-coverage"

phpstan: ## Run phpstan
	@docker exec -it cicd-php bash -c "./vendor/bin/phpstan analyse --memory-limit=-1"

lint: ## Run lint
	@docker exec -it cicd-php bash -c "./vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.dist.php --dry-run --diff --show-progress=none -v"
	
fix: ## Run php-cs-fixer
	@docker exec -it cicd-php bash -c "./vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.dist.php --diff -v --show-progress=none"

rector: ## Run rector in dry-run mode
	@docker exec -it cicd-php bash -c "./vendor/bin/rector"

run-rector: ## Run rector process
	@docker exec -it cicd-php bash -c "./vendor/bin/rector process --config rector.php"

#insights: ## Run insights
#	@docker compose run --user ${WWW_USER_ID} --rm composer /bin/sh -c "composer insights"

