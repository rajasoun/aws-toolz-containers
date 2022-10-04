# aws-iam-authenticator
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as aws-iam-authenticator

ENV AWS_IAM_AUTHENTICATOR_URL=https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
RUN set -ex \
    && curl  -L -o /usr/local/bin/aws-iam-authenticator ${AWS_IAM_AUTHENTICATOR_URL} \
    && chmod +x /usr/local/bin/aws-iam-authenticator
