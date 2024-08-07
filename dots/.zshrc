# Flutter
export PATH=$PATH:$HOME/.fvm_flutter/bin
export PATH=$PATH:$HOME/fvm/default/bin
export PATH=$PATH:$HOME/.pub-cache/bin

# POETRY
export PATH=$PATH:$HOME/.local/bin

# ZIG
export PATH=$PATH:$HOME/.zig/

# Set up fzf key bindings and fuzzy completion
export PATH=$PATH:$HOME/.fzf/bin
eval "$(fzf --zsh)"
bindkey "ç" fzf-cd-widget

# Lazy-load antidote and generate the static load file only when needed
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source /${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

## Asynchronously load NVM
export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

# Initialize worker
async_start_worker nvm_worker -n
async_register_callback nvm_worker load_nvm
async_job nvm_worker sleep 0.1

alias ls="ls --color"
alias tree="tree -C"

export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g

# pnpm
export PNPM_HOME="/Users/maranix/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="/usr/local/opt/mysql-client/bin:$PATH"
