ARG VERSION="1.0.0"
FROM rajasoun/rajasoun/aws-toolz-assembly-base:${VERSION} as aws-toolz-assembly

ARG USERNAME=vscode
# COPY .zshrc & chnagelog config 
COPY dotfiles/.zshrc        /home/$USERNAME/
COPY dotfiles/.czrc         /home/$USERNAME/

# oh-my-zsh plugins
ARG PLUGIN_FOLDER="/home/$USERNAME/.oh-my-zsh/custom/plugins"
RUN set -ex \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_FOLDER"/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_FOLDER"/zsh-autosuggestions

# Pulumi 
RUN set -ex \
    && curl -fsSL https://get.pulumi.com | bash -s -- --version 