-- Autocompletion
return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        {
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        { 'saadparwaiz1/cmp_luasnip' },
    },
    event = 'InsertEnter',
    config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip').filetype_extend("dart", { "flutter" })

        local cmp = require('cmp')
        cmp.setup({
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            }),
            formatting = {
                -- changing the order of fields so the icon is the first
                fields = { 'menu', 'abbr', 'kind' },

                -- here is where the change happens
                format = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = 'λ',
                        luasnip = '⋗',
                        buffer = 'Ω',
                        path = '🖫',
                        nvim_lua = 'Π',
                    }

                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },
            snippet = {
                expand = function(args)
                    -- vim.snippet.expand(args.body)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),

                -- Jump to the next snippet placeholder
                ['<C-f>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                -- Jump to the previous snippet placeholder
                ['<C-b>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
        })
    end
}
