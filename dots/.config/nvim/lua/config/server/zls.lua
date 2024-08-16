local util = require 'lspconfig.util'

-- Currently autoformat on save is broken and hangs up the IDE
vim.g.zig_fmt_autosave = 0

return {
    default_config = {
        cmd = { 'zls' },
        filetypes = { 'zig', 'zir' },
        root_dir = util.root_pattern('zls.json', 'build.zig', '.git'),
        single_file_support = true,
    },
    docs = {
        description = [[
https://github.com/zigtools/zls

Zig LSP implementation + Zig Language Server
        ]],
        default_config = {
            root_dir = [[util.root_pattern("zls.json", "build.zig", ".git")]],
        },
    },
}
