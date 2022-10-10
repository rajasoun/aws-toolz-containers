# awsets - crawls an AWS account and exporting all its resources for further analysis
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as aws-crawl

ENV AWSETS_CLI_VERSION 1.1.1
ENV ARCH arm64

RUN set -ex \
    && curl -OL "https://github.com/trek10inc/awsets/releases/download/v${AWSETS_CLI_VERSION}/awsets_${AWSETS_CLI_VERSION}_linux_${ARCH}.tar.gz" \
    && tar -xvzf "awsets_${AWSETS_CLI_VERSION}_linux_${ARCH}.tar.gz" \
    && mv awsets /usr/local/bin/aws-crawl

