# aws-vault CLI
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as aws-vault
ENV AWS_VAULT_URL=github.com/99designs/aws-vault/releases/download
ENV AWS_VAULT_VERSION=v6.6.0
RUN set -ex \
    && curl -L -o /usr/local/bin/aws-vault \
        https://${AWS_VAULT_URL}/${AWS_VAULT_VERSION}/aws-vault-linux-amd64 \
    && chmod 755 /usr/local/bin/aws-vault