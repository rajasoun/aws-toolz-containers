# teller
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as teller

## teller
ENV TELLER_VERSION 1.5.6
ENV ARCH arm64

RUN set -ex \
    && curl -OL "https://github.com/tellerops/teller/releases/download/v${TELLER_VERSION}/teller_${TELLER_VERSION}_Linux_${ARCH}.tar.gz" \
    && tar -xvzf "teller_${TELLER_VERSION}_Linux_${ARCH}.tar.gz" \
    && mv teller /usr/local/bin/teller

