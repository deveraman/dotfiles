local lsp_zero = require('lsp-zero')
local util = require('util')

local ensure_installed = { 'astro', 'gopls', 'tsserver' }

local servers = {
    'dartls',
    'gopls',
}

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = ensure_installed,
    handlers = {
        lsp_zero.default_setup,
    }
})

for _, server in ipairs(servers) do
    util.set_server_config(server)
end
