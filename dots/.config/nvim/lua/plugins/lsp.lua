local ensure_installed = {
    'biome',
    'cssls',
    'gopls',
    'html',
    'lua_ls',
    'pyright',
    'ruff',
    'tailwindcss',
    'ts_ls',
    'volar',
    'zls',
}

-- These LSPs are not supported or provided by mason
-- Hence they need to be handled and initialied separately
local global_lsps = {
    'dartls',
}


local function setup_format_on_save(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
        return
    end

    if client.supports_method('textDocument/formatting') then
        local bufnr = event.bufnr
        local group = 'lsp_autoformat'
        vim.api.nvim_create_augroup(group, { clear = false })
        vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            group = group,
            desc = 'LSP format on save',
            callback = function()
                -- note: do not enable async formatting
                vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
            end,
        })
    end
end

local function setup_nvim_lspconfig()
    local lsp_defaults = require('lspconfig').util.default_config

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    -- This should be executed before you configure any language server
    lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
    )

    -- LspAttach is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            -- Setup Format on Save if the Lsp Server has capability
            setup_format_on_save(event)

            local opts = { buffer = event.buf }

            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

            vim.keymap.set({ 'n', 'x' }, '<leader>f',
                '<cmd>lua vim.lsp.buf.format({async = false, timeout_ms = 10000})<cr>', opts)

            vim.keymap.set("i", "<C-h>", '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
            vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)

            vim.keymap.set("n", "<leader>vws", '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
            vim.keymap.set("n", "<leader>vd", '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
            vim.keymap.set("n", "<leader>vca", '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            vim.keymap.set("n", "<leader>vrf", '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set("n", "<leader>vrn", '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        end,
    })
end

local function setup_mason()
    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = ensure_installed,
        handlers = {
            function(server_name)
                if server_name == "ruff_lsp" then
                    server_name = "ruff"
                end

                local server = require("servers." .. server_name)
                require('lspconfig')[server_name].setup(server.default_config)
            end,
        }
    })

    -- Setup rest of the LSPs which are not provided by mason
    for i = 1, #global_lsps do
        local server = require("servers." .. global_lsps[i])
        require('lspconfig')[global_lsps[i]].setup(server.default_config)
    end
end

return {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
    },
    init = function()
        -- Reserve a space in the gutter
        -- This will avoid an annoying layout shift in the screen
        vim.opt.signcolumn = 'yes'
    end,
    config = function()
        setup_nvim_lspconfig()
        setup_mason()
    end
}
