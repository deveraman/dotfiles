return {
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro" },
    root_dir = require('lspconfig.util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    init_options = {
        typescript = {
            hostInfo = "neovim"
        }
    },
}
