local config = {
    signcolumn = true,
    current_line_blame = true,
    attach_to_untracked = false,
}


return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup(config)
    end
}
