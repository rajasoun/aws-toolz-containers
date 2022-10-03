# aws-sso CLI
ARG BASE_IMAGE
ARG VERSION

FROM ${BASE_IMAGE}:${VERSION}  as aws-sso

ENV USER_NAME=""
ENV USER_EMAIL=""

COPY bin/aws-sso /usr/local/bin/aws-sso
COPY scripts/aws-sso-init.sh /scripts/aws-sso-init.sh

