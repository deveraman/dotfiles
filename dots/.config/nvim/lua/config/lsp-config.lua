local lsp_zero = require('lsp-zero')
local util = require('util')
local luasnip = require('luasnip')

local ensure_installed = {
    'biome',
    'gopls',
    'lua_ls',
    'pyright',
    'ruff_lsp',
    'zls',
    'tailwindcss',
    'tsserver',
    'volar',
}

local lsp_list = {
    'biome',
    'dartls',
    'gopls',
    'lua_ls',
    'pyright',
    'ruff_lsp',
    'zls',
    'tailwindcss',
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

luasnip.filetype_extend("dart", { "flutter" })
