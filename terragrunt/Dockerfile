# terragrunt
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as terragrunt
ARG TERRAGRUNT_VERSION=0.38.5

ENV TERRAGRUNT_INSTALL_SCRIPT="https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64"
RUN set -ex \
    && wget -q  "$TERRAGRUNT_INSTALL_SCRIPT" \
    && chmod 0755 terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 /usr/local/bin/terragrunt
