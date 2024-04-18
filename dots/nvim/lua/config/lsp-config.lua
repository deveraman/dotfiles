local lsp_zero = require('lsp-zero')
local util = require('util')

local ensure_installed = {
    'gopls',
    'lua_ls',
    'pyright',
    'ruff_lsp',
    'rust_analyzer',
    'tsserver',
    'volar',
}

local lsp_list = {
    'dartls',
    'gopls',
    'lua_ls',
    'pyright',
    'ruff_lsp',
    'rust_analyzer',
    'tsserver',
    'volar',
}

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = ensure_installed,
    handlers = {
        lsp_zero.default_setup,
    }
})

for _, lsp in ipairs(lsp_list) do
    util.set_server_config(lsp)
end
