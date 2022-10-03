# aws-sso CLI
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as aws-sso

COPY bin/aws-sso /usr/local/bin/aws-sso

COPY scripts/aws-sso-init.sh /scripts/aws-sso-init.sh

