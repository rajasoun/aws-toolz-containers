# aws-nuke CLI
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as aws-nuke
ENV AWS_NUKE_URL=github.com/rebuy-de/aws-nuke/releases/download
ENV AWS_NUKE_VERSION=v2.19.0
ENV AWS_NUKE_EXEC=aws-nuke-${AWS_NUKE_VERSION}-linux-amd64

RUN set -ex \
    && wget -c https://${AWS_NUKE_URL}/$AWS_NUKE_VERSION/${AWS_NUKE_EXEC}.tar.gz -O - | \
       tar -xz -C /tmp
RUN set -ex \
    && mv /tmp/${AWS_NUKE_EXEC} /usr/local/bin/aws-nuke
