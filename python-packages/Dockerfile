# python-packages
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as python-packages

# pip requirements rarely change
COPY packages/*.* /tmp/packages-tmp/
