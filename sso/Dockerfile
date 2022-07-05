# aws-sso CLI
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as aws-sso

# ENV AWS_SSO_URL=wwwin-github.cisco.com/ATS-operations/duo-sso/releases/download
# ENV AWS_SSO_VERSION=v2.7.0
# RUN set -ex \
#     && curl -L -o /usr/local/bin/aws-sso \
#         https://${AWS_SSO_URL}/${AWS_SSO_VERSION}/duo-sso_linux_amd64 \
#     && chmod 755 /usr/local/bin/aws-sso

COPY bin/aws-sso /usr/local/bin/aws-sso
