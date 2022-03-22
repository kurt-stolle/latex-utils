all: build

.PHONY: build create

# Builds the Docker container
build:
	docker build \
		--build-arg TEX_USER=$$(whoami) \
		--build-arg TEX_UID=$$(id -u) \
		--build-arg TEX_GID=$$(id -g) \
		--tag latex-utils:latest \
		.

# Creates a Docker container for the specified project
create:
	docker create \
		--name $(PROJECT_NAME) \
		--volume $(PROJECT_ROOT):/var/tex/ \
		latex-utils:latest

