FROM ubuntu:focal
ENV DEBIAN_FRONTEND noninteractive

# Install texlive packages from the Ubuntu repositories
RUN apt-get update -q && apt-get install -qy ttf-mscorefonts-installer texlive texlive-science texlive-pictures texlive-xetex latexmk

# Create a volume containing TeX sources
WORKDIR /var/tex
VOLUME /var/tex

# Entrypoint
SHELL ["/bin/bash"]
ENTRYPOINT ["latexmk"]
CMD ["main.tex"]

