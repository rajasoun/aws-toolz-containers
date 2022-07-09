# aws-toolz

ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:1.0.0 as aws-toolz-base

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

COPY --from=rajasoun/aws-toolz-workspace-scripts:1.0.0          /workspaces                            /workspaces

# COPY .zshrc & chnagelog config 
COPY dotfiles/.zshrc        /home/$USERNAME/
COPY dotfiles/.czrc         /home/$USERNAME/

# aws cli 
RUN set -ex \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update \
    && aws --version

ARG USERNAME=vscode
RUN set -ex \
    && useradd -rm -d /home/$USERNAME -s /bin/zsh -g root -G sudo -u 1001 $USERNAME \
    && echo 'vscode  ALL=(ALL) NOPASSWD:ALL' >>  /etc/sudoers

RUN id -u $USERNAME | xargs -I{} chown -R {}:{} /home/$USERNAME

# Remove library scripts for final image
RUN set -ex \
    && apt-get --purge remove unzip python3-pip -y \
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/library-scripts \
    && rm -rf /tmp/packages-tmp \
    && rm -rf /tmp/*