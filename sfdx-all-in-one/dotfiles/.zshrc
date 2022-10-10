export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell" #"codespaces"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true

## Aplication Specfic Setup
export AWS_VAULT_PASS_PREFIX=aws-vault
export AWS_VAULT_BACKEND=pass
export GPG_TTY="$(tty)"
export PRE_COMMIT_ALLOW_NO_CONFIG=1

PGP_DIR="$(git rev-parse --show-toplevel)/.config/.gpg2/keys"
export GNUPGHOME="$PGP_DIR"

if [ -z $IGNORE_GHELP ];then
    source /workspaces/automator/ghelp.bash
fi

# NVM Loader
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/zsh_completion" ] && \. "$NVM_DIR/zsh_completion"
