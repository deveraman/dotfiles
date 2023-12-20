local lsp_zero = require('lsp-zero')
local util = require('util')

local ensure_installed = {
    'astro',
    'gopls',
    'tsserver',
    'pyright',
}

local servers = {
    'astro',
    'dartls',
    'gopls',
    'tsserver',
    'pyright',
}

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = ensure_installed,
    handlers = {
        lsp_zero.default_setup,
    }
})

require('config.mason').setup()

for _, server in ipairs(servers) do
    util.set_server_config(server)
end
