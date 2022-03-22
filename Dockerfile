FROM ubuntu:focal
MAINTAINER Kurt Stolle <k.h.w.stolle@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Install texlive packages from the Ubuntu repositories
RUN apt-get update -q && apt-get install -qy ttf-mscorefonts-installer texlive texlive-science texlive-pictures texlive-xetex latexmk

# Create a user. Using the same UID and GID as the host user can be useful when
# using this image as a development container, mounting the source directory 
# and editing these files on the host.
# 
# docker build --build-arg TEX_USER=$(whoami) --build-arg TEX_UID=$(id -u) --build-arg TEX_GID=$(id -g) ...
ARG TEX_USER=texuser
ARG TEX_UID=1000
ARG TEX_GID=1000
RUN groupadd -g $TEX_GID -o $TEX_USER
RUN useradd -g $TEX_GID -u $TEX_UID -m -d "/var/tex" -o -s /bin/bash "$TEX_USER"
USER $TEX_USER

# Create a volume containing TeX sources
WORKDIR /var/tex
VOLUME /var/tex

# Entrypoint
ENTRYPOINT ["latexmk"]
CMD ["main.tex"]

