# base image
FROM debian:bullseye-slim as base
RUN set -x \
    && apt-get update \
    && apt-get upgrade -y \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
       zsh-autosuggestions make \
       zsh-syntax-highlighting python3-pip \
       pass gnupg2 httpie netcat sudo \
       curl wget ca-certificates git \
    && apt-get autoremove -y  \
    && apt-get clean -y \
    && rm -r /var/cache/* /var/lib/apt/lists/*

# pip requirements rarely change
COPY packages/*.* /tmp/packages-tmp/

# Python Packages - .devcontainer packages
RUN set -ex \
    && pip3 --disable-pip-version-check \
            --no-cache-dir install -r /tmp/packages-tmp/requirements.txt

# Remove library scripts for final image
RUN set -ex \
    && apt-get --purge remove python3-pip -y \
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/library-scripts \
    && rm -rf /tmp/packages-tmp \
    && rm -rf /tmp/*
