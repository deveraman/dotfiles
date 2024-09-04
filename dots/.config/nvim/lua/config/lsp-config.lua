local lsp_zero = require('lsp-zero')
local util = require('util')
local luasnip = require('luasnip')

local ensure_installed = {
    'biome',
    'cssls',
    'gopls',
    'html',
    'lua_ls',
    'pyright',
    'ruff_lsp',
    'tailwindcss',
    'tsserver',
    'volar',
    'zls',
}

local lsp_list = {
    'biome',
    'cssls',
    'dartls',
    'gopls',
    'html',
    'lua_ls',
    'pyright',
    'ruff_lsp',
    'tailwindcss',
    'tsserver',
    'volar',
    'zls',
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
