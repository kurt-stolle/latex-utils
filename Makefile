all: build

.PHONY: build create start compile

# Builds the Docker image.
build:
	docker build \
		--tag latex-utils:latest \
		.

# Creates a Docker container for the specified project.
create:
	docker create \
		--name $(PROJECT_NAME) \
		--volume $(PROJECT_ROOT):/var/tex/ \
		latex-utils:latest $$ARGS

# Starts a Docker container by project name.
start:
	docker start \
		-ita
		$(PROJECT_NAME) 

# Compile a a project in an ad-hoc continaer
compile:
	docker run \
		--rm \
		--volume $(PROJECT_ROOT):/var/tex \
		latex-utils:latest $$ARGS
