return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('config.git-signs')
        vim.wo.signcolumn = "yes"
    end
}
