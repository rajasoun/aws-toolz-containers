# grype support
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as grype
ENV GRYPE_INSTALL_SCRIPT="https://raw.githubusercontent.com/anchore/grype/main/install.sh"
RUN set -ex \
    && curl -sSfL "$GRYPE_INSTALL_SCRIPT" | sh -s -- -b /usr/local/bin
