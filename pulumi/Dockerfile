# pulumi
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as pulumi

RUN set -ex \
    && curl -fsSL https://get.pulumi.com | sh
