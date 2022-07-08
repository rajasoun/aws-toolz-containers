# aws-toolz

ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:1.0.0 as aws-toolz

# COPY Python Packages
COPY --from=rajasoun/aws-toolz-python-packages:1.0.0  /tmp/packages-tmp/    /tmp/packages-tmp/

RUN set -ex \
    && /tmp/packages-tmp/setup.sh

# COPY tools
COPY --from=rajasoun/aws-toolz-aws-vault:1.0.0                 /usr/local/bin/aws-vault                /usr/local/bin/aws-vault
COPY --from=rajasoun/aws-toolz-cloud-nuke:1.0.0                /usr/local/bin/cloud-nuke               /usr/local/bin/cloud-nuke
COPY --from=rajasoun/aws-toolz-aws-nuke:1.0.0                  /usr/local/bin/aws-nuke                 /usr/local/bin/aws-nuke
COPY --from=rajasoun/aws-toolz-awless:1.0.0                    /usr/local/bin/awless                   /usr/local/bin/awless
COPY --from=rajasoun/aws-toolz-fetch:1.0.0                     /usr/local/bin/fetch                    /usr/local/bin/fetch
COPY --from=rajasoun/aws-toolz-syft:1.0.0                      /usr/local/bin/syft                     /usr/local/bin/syft
COPY --from=rajasoun/aws-toolz-grype:1.0.0                     /usr/local/bin/grype                    /usr/local/bin/grype
COPY --from=rajasoun/aws-toolz-kubectl:1.0.0                   /usr/local/bin/kubectl                  /usr/local/bin/kubectl
COPY --from=rajasoun/aws-toolz-eksctl:1.0.0                    /usr/local/bin/eksctl                   /usr/local/bin/eksctl
COPY --from=rajasoun/aws-toolz-helm:1.0.0                      /usr/local/bin/helm                     /usr/local/bin/helm
COPY --from=rajasoun/aws-toolz-sentry:1.0.0                    /usr/local/bin/sentry-cli               /usr/local/bin/sentry-cli
COPY --from=rajasoun/aws-toolz-gh:1.0.0                        /usr/bin/gh                             /usr/local/bin/gh
COPY --from=rajasoun/aws-toolz-aws-iam-authenticator:1.0.0     /usr/local/bin/aws-iam-authenticator    /usr/local/bin/aws-iam-authenticator
COPY --from=rajasoun/aws-toolz-sso:1.0.0                       /usr/local/bin/aws-sso                  /usr/local/bin/aws-sso

# COPY Sift Left Security
COPY    shift-left    /workspaces/shift-left
COPY    dotfiles/.czrc     /home/$USERNAME/

# COPY Automator & Tests
COPY    automator     /workspaces/automator
COPY    tests         /workspaces/tests

# COPY .zshrc
COPY dotfiles/.zshrc        /home/$USERNAME/

ARG USERNAME=vscode
RUN set -ex \
    && useradd -rm -d /home/$USERNAME -s /bin/zsh -g root -G sudo -u 1001 $USERNAME \
    && echo 'vscode  ALL=(ALL) NOPASSWD:ALL' >>  /etc/sudoers

RUN id -u $USERNAME | xargs -I{} chown -R {}:{} /home/$USERNAME

# Remove library scripts for final image
RUN set -ex \
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/library-scripts \
    && rm -rf /tmp/packages-tmp \
    && rm -rf /tmp/*

ARG USERNAME=vscode
USER $USERNAME
WORKDIR /home/$USERNAME

# oh-my-zsh
ARG PLUGIN_FOLDER="/home/$USERNAME/.oh-my-zsh/custom/plugins"
RUN set -ex \
    && curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_FOLDER"/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_FOLDER"/zsh-autosuggestions

# Pulumi 
RUN set -ex \
    && curl -fsSL https://get.pulumi.com | bash -s -- --version 

