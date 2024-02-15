# Define default command to use when none is provided to make
.DEFAULT_GOAL := help

# Define help command to list available commands
help:
	@echo "Available commands:"
	@echo "  build     Build the Docker images for the application"
	@echo "  up        Up the Docker containers for the application"
	@echo "  start     Start the Docker containers for the application"
	@echo "  stop      Stop the Docker containers for the application"
	@echo "  down      Down the Docker containers for the application"

# Build Docker images
build:
	docker-compose build

# Run Docker containers
up: build
	docker-compose up -d --scale worker=4

start: build
	docker-compose start -d --scale worker=4

stop:
	docker-compose stop

down:
	docker-compose down

.PHONY: help build up start stop down
