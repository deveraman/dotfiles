return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
    },
    {
        'nyoom-engineering/oxocarbon.nvim',
        config = function()
            vim.opt.background = "dark"
            vim.cmd.colorscheme('oxocarbon')
        end
    }
}
