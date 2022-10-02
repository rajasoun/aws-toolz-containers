# packer
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as packer
ARG PACKER_VERSION=1.8.2

ENV PACKER_INSTALL_SCRIPT="https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"
RUN set -ex \
    && wget -q  "$PACKER_INSTALL_SCRIPT" \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip \
    && mv packer /usr/local/bin
