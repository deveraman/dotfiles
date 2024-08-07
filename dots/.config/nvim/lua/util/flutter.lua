-- Flutter wrapper for hot-reloading
-- Put this in your plugin directory (Default is $HOME/.config/nvim/lua/plugin/flutter.lua)
--
--
local function flutter_hot_reload()
    vim.fn.system('kill -s USR1 "$(pgrep -f flutter_tools.snapshot\\ run)" &> /dev/null')
end

-- Autocommand for hot-reloading on save
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*/lib/*.dart',
    callback = flutter_hot_reload,
})
