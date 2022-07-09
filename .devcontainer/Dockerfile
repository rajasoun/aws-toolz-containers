ARG VERSION="1.0.0"
FROM rajasoun/aws-toolz-assembly:${VERSION} as aws-toolz-assembly

ARG USERNAME=vscode
# COPY .zshrc & chnagelog config 
COPY dotfiles/.zshrc        /home/$USERNAME/
COPY dotfiles/.czrc         /home/$USERNAME/

