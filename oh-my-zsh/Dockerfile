# oh-my-zsh plugins
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as oh-my-zsh
# 	zsh-autosuggestions - suggests commands as you type based on history and completions
#   zsh-syntax-highlighting - enables highlighting of commands as they are typed at a zsh prompt
ARG USERNAME=vscode
ARG PLUGIN_FOLDER="/home/$USERNAME/.oh-my-zsh/custom/plugins"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_FOLDER"/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_FOLDER"/zsh-autosuggestions

COPY dotfiles/.zshrc /home/$USERNAME/