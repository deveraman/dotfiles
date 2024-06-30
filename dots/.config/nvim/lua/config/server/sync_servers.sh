#!/usr/bin/env bash

set -e

declare EXTENSION="lua"

declare HOST="raw.githubusercontent.com"
declare CONFIG_PATH="neovim/nvim-lspconfig/master/lua/lspconfig/server_configurations"
declare URI_PREFIX="https://$HOST/$CONFIG_PATH"

declare SERVERS=(
	biome
	dartls
	gopls
	lua_ls
	pyright
	ruff_lsp
	tailwindcss
	tsserver
	volar
	zls
)

echo "Downloading...."

for SERVER in "${SERVERS[@]}";do
	echo "Fetching $SERVER"
	curl "$URI_PREFIX/$SERVER.$EXTENSION" -o $SERVER.$EXTENSION
done

echo "Done"
