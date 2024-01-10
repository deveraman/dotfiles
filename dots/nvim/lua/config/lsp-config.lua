local lsp_zero = require('lsp-zero')
local util = require('util')

local ensure_installed = {
    'gopls',
    'pyright',
    'ruff_lsp',
    'rust_analyzer',
    'svelte',
    'tsserver',
}

local servers = {
    'dartls',
    'gopls',
    'pyright',
    'ruff_lsp',
    'rust_analyzer',
    'svelte',
    'tsserver',
}

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = ensure_installed,
    handlers = {
        lsp_zero.default_setup,
    }
})

for _, server in ipairs(servers) do
    util.set_server_config(server)
end
