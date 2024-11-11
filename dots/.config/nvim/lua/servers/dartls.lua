local util = require 'lspconfig.util'

-- Flutter wrapper for hot-reloading
-- Put this in your plugin directory (Default is $HOME/.config/nvim/lua/plugin/flutter.lua)
--
--
local function hot_reload()
    vim.fn.system('kill -s USR1 "$(pgrep -f flutter_tools.snapshot\\ run)" &> /dev/null')
end

-- Autocommand for hot-reloading on save
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*/lib/*.dart',
    callback = hot_reload,
})

return {
    default_config = {
        cmd = { 'dart', 'language-server', '--protocol=lsp' },
        filetypes = { 'dart' },
        root_dir = util.root_pattern 'pubspec.yaml',
        init_options = {
            onlyAnalyzeProjectsWithOpenFiles = true,
            suggestFromUnimportedLibraries = true,
            closingLabels = true,
            outline = true,
            flutterOutline = true,
        },
        settings = {
            dart = {
                completeFunctionCalls = true,
                showTodos = true,
            },
        },
    },
    docs = {
        description = [[
https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec

Language server for dart.
]],
    },
}
