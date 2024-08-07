return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
        {"hrsh7th/cmp-buffer"},
        {"saadparwaiz1/cmp_luasnip"},

        {'L3MON4D3/LuaSnip'},
        {"rafamadriz/friendly-snippets"},
    },
    config = function()
        require('config.cmp')
    end
}
