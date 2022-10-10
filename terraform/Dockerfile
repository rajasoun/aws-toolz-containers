# terraform
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as terraform
ARG TERRAFORM_VERSION=1.3.2
ENV TERRAFORM_INSTALL_SCRIPT="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
RUN set -ex \
    && wget -q  "$TERRAFORM_INSTALL_SCRIPT" \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin
