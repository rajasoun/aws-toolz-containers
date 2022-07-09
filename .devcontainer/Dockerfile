ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT} 

# Python Packages
COPY --from=rajasoun/aws-toolz-python-packages:1.0.0    /tmp/packages-tmp/    /tmp/packages-tmp/
RUN set -ex \
    && /tmp/packages-tmp/setup.sh

# Tools
COPY --from=rajasoun/aws-toolz-assembly-base:1.0.0      /usr/local/bin      /usr/local/bin
COPY --from=rajasoun/aws-toolz-assembly-base:1.0.0      /usr/local/aws-cli  /usr/local/aws-cli

# Workspace scripts
COPY --from=rajasoun/aws-toolz-workspace-scripts:1.0.0  /workspaces         /workspaces

# Dotfiles 
# COPY .zshrc & .czrc     
COPY --from=rajasoun/aws-toolz-assembly-base:1.0.0      /home/$USERNAME/.zshrc    /home/$USERNAME/
COPY --from=rajasoun/aws-toolz-assembly-base:1.0.0      /home/$USERNAME/.czrc     /home/$USERNAME/

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