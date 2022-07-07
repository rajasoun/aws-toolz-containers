# Pulumi
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as pulumi

ARG USERNAME=vscode
RUN useradd -rm -d /home/$USERNAME -s /bin/bash -g root -G sudo -u 1001 $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

RUN set -ex \
    && curl -fsSL https://get.pulumi.com | bash -s -- --version 

# Will be Stored in  
