# sfdx-toolz-assembly

ARG BASE_IMAGE
ARG VERSION

FROM ${BASE_IMAGE}:1.0.0 as sfdx-toolz-assembly


RUN set -x \
    && apt-get update \
    && apt-get upgrade -y \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
       gcc python3-dev python3-venv \
    && apt-get autoremove -y  \
    && apt-get clean -y \
    && rm -r /var/cache/* /var/lib/apt/lists/*

# COPY Python Packages
COPY packages    /tmp/packages-tmp/

RUN set -ex \
    && /tmp/packages-tmp/setup.sh

COPY --from=rajasoun/dev-toolz-fetch:1.0.0                     /usr/local/bin/fetch                    /usr/local/bin/fetch
COPY --from=rajasoun/dev-toolz-sentry:1.0.0                    /usr/local/bin/sentry-cli               /usr/local/bin/sentry-cli
COPY --from=rajasoun/dev-toolz-gh:1.0.0                        /usr/bin/gh                             /usr/local/bin/gh


COPY --from=rajasoun/dev-toolz-workspace-scripts:1.0.0          /workspaces                            /workspaces


# Install NVM
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 18.10.0
ARG SALESFORCE_CLI_VERSION=latest

RUN set -ex \
    && mkdir -p /usr/local/nvm \
    && curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh" | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

# Remove library scripts for final image
RUN set -ex \
    && apt-get --purge remove unzip -y \
    && apt-get --purge remove gcc python3-dev python3-venv  -y \
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/library-scripts \
    && rm -rf /tmp/packages-tmp \
    && rm -rf /tmp/*

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME
