# eksctl
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as eksctl
ENV EKSCTL_TAR="https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz"
RUN set -ex \
    && curl --silent --location "$EKSCTL_TAR" | tar xz -C /tmp \
    && mv /tmp/eksctl /usr/local/bin \
    && chmod +x /usr/local/bin/eksctl
