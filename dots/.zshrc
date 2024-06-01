# Set kitty theme
kitty +kitten themes kanagawa_dragon

# Flutter
export PATH=$PATH:$HOME/.fvm_flutter/bin
export PATH=$PATH:$HOME/fvm/default/bin

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
