return {
    { 'morhetz/gruvbox',
        -- config = function()
        --     vim.g.gruvbox_contrast_dark = "dark"
        --     vim.cmd.colorscheme('gruvbox')
        -- end
    },
    {
        'rebelot/kanagawa.nvim',
        config = function()
            require("kanagawa").load("dragon")
        end
    },
}
