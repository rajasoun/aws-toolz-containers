ARG BASE_ASSEMBLY_IMAGE="aws-assembly"
ARG VERSION="1.0.0"
FROM rajasoun/dev-toolz-${BASE_ASSEMBLY_IMAGE}:${VERSION}

ARG USERNAME=vscode
USER $USERNAME

# oh-my-zsh plugins
ARG PLUGIN_FOLDER="/home/$USERNAME/.oh-my-zsh/custom/plugins"
RUN set -ex \
    && curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_FOLDER"/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_FOLDER"/zsh-autosuggestions \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME

RUN id -u $USERNAME | xargs -I{} chown -R {}:{} /home/$USERNAME

# COPY .zshrc & chnagelog config
COPY dotfiles/.zshrc        /home/$USERNAME/
COPY dotfiles/.czrc         /home/$USERNAME/
