# Latex Utils
Utilities for building scientific articles and reports using LaTeX. Uses a Docker container to facilitate a consistent environement across different operating systems.

The container image is based on Ubuntu 20.04 (focal) LTS. [TeX Live](https://www.tug.org/texlive/) is used for building LaTeX documents. Dependent packages are pulled from the default APT repositories.

## Usage
### Basics
First, build the Docker container using `docker build -t latex-utils .`. When using this container for active development, it may be useful to mirror the current user's UID and GID into the user account created inside the container. This is done by providing the build arguments `TEX_UID`, `TEX_GID` and optionally `TEX_USER`. 

After building the image, the environment is accessed through a container instance. Bind mount the project directory containing your LaTeX sources into the `/var/tex` directory.

### Make
A `make` configuration is included. Example usage:
```bash
make build
make create PROJECT_NAME="my_project" PROJECT_ROOT="./src/my_project"
make start PROJECT_NAME="my_project"
```
Use `make compile PROJECT_ROOT="./src/my_project` to compile in a dummy container.

### Additional dependencies
Add packages by creating a derivative Dockerfile and installing the desired software.

## About
This repository was made public with the intention of being able to quickly share a working LaTeX environment. It is not actively maintained, but the project is open for suggestions (make an issue).

## Alternatives
If you are looking for a Docker-based LaTeX environment, have a look at the [official Tex Live images](https://hub.docker.com/r/texlive/texlive).

For simple projects that do not require a complex build environment, the intergrated writing environment [TeXstudio](https://www.texstudio.org/) could be a good fit.
