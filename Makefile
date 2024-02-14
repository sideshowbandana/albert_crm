# Define default command to use when none is provided to make
.DEFAULT_GOAL := help

# Define help command to list available commands
help:
	@echo "Available commands:"
	@echo "  build   Build the Docker images for the application"
	@echo "  run     Run the Docker containers for the application"

# Build Docker images
build:
	docker-compose build

# Run Docker containers
run:
	docker-compose up -d

stop:
	docker-compose down

rebuild: stop build run


.PHONY: help build run
