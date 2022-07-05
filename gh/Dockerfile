# github cli 
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as gh
ENV GITHUB_CLI_VERSION 2.13.0
RUN set -ex \
    curl -L "https://github.com/cli/cli/releases/download/v${GITHUB_CLI_VERSION}/gh_${GITHUB_CLI_VERSION}_checksums.txt" -o checksums.txt \
    curl -OL "https://github.com/cli/cli/releases/download/v${GITHUB_CLI_VERSION}/gh_${GITHUB_CLI_VERSION}_linux_amd64.deb" \
    shasum --ignore-missing -a 512 -c checksums.txt \
	dpkg -i "gh_${GITHUB_CLI_VERSION}_linux_amd64.deb" \
	rm -rf "gh_${GITHUB_CLI_VERSION}_linux_amd64.deb" \
    cp /usr/bin/gh /usr/local/bin/gh \
    gh --version
