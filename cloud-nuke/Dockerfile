# cloud-nuke CLI
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as cloud-nuke
ENV CLOUD_NUKE_URL=github.com/gruntwork-io/cloud-nuke/releases/download
ENV CLOUD_NUKE_VERSION=v0.11.6
RUN set -ex \
    && curl -L -o /usr/local/bin/cloud-nuke \
        https://${CLOUD_NUKE_URL}/${CLOUD_NUKE_VERSION}/cloud-nuke_linux_amd64 \
    && chmod 755 /usr/local/bin/cloud-nuke