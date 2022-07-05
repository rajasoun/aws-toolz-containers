# awless CLI
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION} as awless
ENV AWS_LESS_URL=github.com/wallix/awless/releases/download
ENV AWS_LESS_VERSION=v0.1.11
ENV AWS_LESS_EXEC=awless

RUN set -ex \
    && wget -c https://${AWS_LESS_URL}/$AWS_LESS_VERSION/${AWS_LESS_EXEC}-linux-amd64.tar.gz -O - | \
       tar -xz -C /tmp
RUN set -ex \
    && mv /tmp/${AWS_LESS_EXEC} /usr/local/bin/awless