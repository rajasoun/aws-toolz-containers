# Sentry CLI
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as sentry
RUN set -ex \
    && curl -fsSL https://sentry.io/get-cli/ | bash
