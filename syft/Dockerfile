# syft 
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as syft
ENV SYFT_INSTALL_SCRIPT="https://raw.githubusercontent.com/anchore/syft/main/install.sh"
RUN set -ex \
    && curl -sSfL "$SYFT_INSTALL_SCRIPT" | sh -s -- -b /usr/local/bin 

