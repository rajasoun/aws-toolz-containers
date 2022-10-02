# Fetch CLI
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as fetch
ENV FETCH_URL=github.com/gruntwork-io/fetch/releases/download
ENV FETCH_VERSION=v0.4.4
RUN set -ex \
    && curl -L -o /usr/local/bin/fetch \
        https://${FETCH_URL}/${FETCH_VERSION}/fetch_linux_amd64 \
    && chmod 755 /usr/local/bin/fetch
