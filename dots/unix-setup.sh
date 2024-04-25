#!/usr/bin/env bash

# TODO: Maybe add Uninstall capabilities

# Custom bash script for setting up dev environment for unix systems.
#
# Supported OSes:-
# 1. MacOS
# 2. Fedora
# ....coming soon


# current OS
OS="$(uname -s)"

# packages
PKG_COMMON=(tmux gh ripgrep neovim kitty)
PKG_LINUX=(zsh)

# an array of excutable scripts
HOMEBREW="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
RUST="https://sh.rustup.rs"
NVM="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh"
FVM="https://fvm.app/install.sh"
G_GVM="https://git.io/g-install"
POETRY="https://install.python-poetry.org"
FZF="https://github.com/junegunn/fzf.git"
KITTY_CONF="https://raw.githubusercontent.com/maranix/kosei/main/dots/.config/kitty/kitty.conf"
ZSHRC="https://raw.githubusercontent.com/maranix/kosei/main/dots/.zshrc"
ZSH_PLUGINS="https://raw.githubusercontent.com/maranix/kosei/main/dots/.zsh_plugins.txt"
ANTIDOTE="https://github.com/mattmc3/antidote.git"
declare scripts=(
"curl --proto '=https' --tlsv1.2 -sSf $RUST | sh -s -- -y"
"curl -o- $NVM | bash"
"curl -fsSL $FVM | bash"
"curl -sSL $G_GVM | sh -s -- bash zsh -y"
"curl -sSL $POETRY | python3 -"
"git clone --depth 1 $FZF ~/.fzf"
"curl -fsSL $KITTY_CONF > ~/.config/kitty/kitty.conf"
"curl -fsSL $ZSHRC > ~/.zshrc"
"curl -fsSL $ZSH_PLUGINS > ~/.zsh_plugins.txt"
"git clone --depth=1 $ANTIDOTE ${ZDOTDIR:-$HOME}/.antidote"
)

function is_mac() {
    if [[ $OS == "Darwin" ]]; then
        return 1
    else
        return 0
    fi
}

function process_scripts () {
    for s in "${scripts[@]}"; do
        sh -c "($s)"
    done
    $HOME/.fzf/install

    is_mac
    if [[ $? == 1 ]]; then
       NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL $HOMEBREW)"
    fi
}

function install_pkgs() {
    local pkg_installer
    is_mac
    if [[ $? == 1 ]]; then
        pkg_installer="brew install"
    else
        pkg_installer="sudo dnf install -y"
    fi

    $pkg_installer "${PKG_COMMON[@]}"
    is_mac
    if [[ $? == 0 ]]; then
        $pkg_installer "${PKG_LINUX[@]}"
    fi
}

function install_configs () {
    for s in "${scripts[@]:6}"; do
        sh -c "($s)"
    done
}

function install_silverblue() {
    rpm-ostree "${PKG_LINUX[@]}" kitty
}

function uninstall_homebrew() {
    is_mac
    if [[ $? == 1 ]]; then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    fi
}

function uninstall_poetry() {
    /bin/bash -c "$(curl -sSL https://install.python-poetry.org | python3 - --uninstall)"
}

function run() {
    process_scripts
    install_pkgs
}

# Check if a function with the given name exists
if declare -f "$1" > /dev/null; then
    # If the function exists, call it
    "$@"
else
    echo "
Expected a function name as an argument.

1. process_scripts # Runs all the shell scripts languages/tools/zsh_configs
2. install_pkgs # Install packages
3. install_configs # Installs configuration files
4. install_sliverblue # Installs base packages for silverblue
5. run # Runs both of the above commands
6. uninstall_ # _ followed by the pkg name
    "
    exit 1
fi