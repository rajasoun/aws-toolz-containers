# aws-toolz
FROM aws-toolz-base:1.0.0 as aws-toolz

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

