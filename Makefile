# Define default command to use when none is provided to make
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
# # Define help command to list available commands
# help:
#	@echo "Available commands:"
#	@echo "  build     Build the Docker images for the application"
#	@echo "  up        Up the Docker containers for the application"
#	@echo "  down      Down the Docker containers for the application"

test:
	rspec

# Build Docker images
build:
	docker-compose build

# Run Docker containers
up: build
	docker-compose up -d --scale worker=4

down:
	docker-compose down

sendemails-eager: ## Run the send_email synchronously
	docker compose exec -e EMAIL_TEMPLATE_NAME="welcome" web bin/rails email:send_to_csv

sendemails: ## Run the send_email asynchronously
	docker compose exec -e EMAIL_TEMPLATE_NAME="welcome" -e ASYNC="true" web bin/rails email:send_to_csv

bash: ## Open a shell with all dependencies
	docker compose run web /bin/bash

logs:
	docker-compose logs -f

migrate: ## Apply database migrations
	docker compose run web bin/rails db:migrate

admin: ## Open the Django admin page
	open http://localhost:3000

submit: ## Dump the Postgres database and package your project into a solution.zip file you can submit
	zip -r solution.zip .

.PHONY: help test build up down sendemails-eager sendemails bash migrate admin submit logs
