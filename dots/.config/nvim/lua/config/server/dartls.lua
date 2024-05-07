function DartHotReload()
    vim.cmd [[silent execute '!kill -s USR1 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null']]
end

vim.cmd [[autocmd BufWritePost *.dart lua DartHotReload()]]

return {
    cmd = { 'dart', 'language-server', '--protocol=lsp' },
    filetypes = { 'dart' },
    init_options = {
        closingLabels = true,
        flutterOutline = true,
        onlyAnalyzeProjectsWithOpenFiles = true,
        outline = true,
        suggestFromUnimportedLibraries = true
    },
    root_dir = require('lspconfig.util').root_pattern('pubspec.yaml'),
    setting = {
        dart = {
            completeFunctionCalls = true,
            showTodos = true
        }
    }
}
