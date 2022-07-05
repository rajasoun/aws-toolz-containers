# aws-toolz

ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:1.0.0 as aws-toolz

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
COPY --from=rajasoun/aws-toolz-pulumi:1.0.0                    /usr/local/bin/pulumi                   /usr/local/bin/pulumi
COPY --from=rajasoun/aws-toolz-gh:1.0.0                        /usr/bin/gh                             /usr/local/bin/gh
COPY --from=rajasoun/aws-toolz-aws-iam-authenticator:1.0.0     /usr/local/bin/aws-iam-authenticator    /usr/local/bin/aws-iam-authenticator

# COPY Automator
COPY    shift-left    /workspaces/shift-left
COPY    tests         /workspaces/tests
COPY    automator     /workspaces/automator

ARG USERNAME=vscode
RUN useradd -rm -d /home/$USERNAME -s /bin/bash -g root -G sudo -u 1001 $USERNAME
# RUN usermod -a -G sudo $USERNAME
RUN echo 'vscode  ALL=(ALL) /bin/su' >>  /etc/sudoers

# Remove library scripts for final image
RUN set -ex \
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/library-scripts \
    && rm -rf /tmp/packages-tmp \
    && rm -rf /tmp/*

USER $USERNAME
WORKDIR /home/$USERNAME

RUN set -ex \
    && curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

ARG PLUGIN_FOLDER="/home/$USERNAME/.oh-my-zsh/custom/plugins"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_FOLDER"/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_FOLDER"/zsh-autosuggestions

# COPY Dotfiles
COPY dotfiles/.zshrc    /home/$USERNAME/
COPY dotfiles/.czrc     /home/$USERNAME/



