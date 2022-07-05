# helm
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as helm
RUN set -ex \
    && curl -sSfL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash