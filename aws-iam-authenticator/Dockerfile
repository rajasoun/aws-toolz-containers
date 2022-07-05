# aws-iam-authenticator
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as aws-iam-authenticator
ENV AWS_IAM_AUTHENTICATOR_VERSION=0.5.9
ENV AWS_IAM_AUTHENTICATOR_BASE_URL=https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/
ENV AWS_IAM_AUTHENTICATOR_URL=${AWS_IAM_AUTHENTICATOR_BASE_URL}/${AWS_IAM_AUTHENTICATOR_VERSION}/aws-iam-authenticator_${AWS_IAM_AUTHENTICATOR_VERSION}_linux_amd64
RUN set -ex \
    && curl  -L -o /usr/local/bin/aws-iam-authenticator ${AWS_IAM_AUTHENTICATOR_URL} \
    && chmod +x /usr/local/bin/aws-iam-authenticator