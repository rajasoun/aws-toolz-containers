# base image
FROM debian:bullseye-slim as base
RUN set -x \
    && apt-get update \
    && apt-get upgrade -y \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
       zsh-autosuggestions make \
       zsh-syntax-highlighting python3-pip\
       pass gnupg2 httpie netcat sudo \
       curl wget ca-certificates git \
    && apt-get autoremove -y  \
    && apt-get clean -y \
    && rm -r /var/cache/* /var/lib/apt/lists/*

# Remove library scripts for final image
RUN set -ex \
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/library-scripts \
    && rm -rf /tmp/packages-tmp \
    && rm -rf /tmp/*
    
