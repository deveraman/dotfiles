return {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { 'vue', 'json' },
    root_dir = require('lspconfig.util').root_pattern("package.json", ".git"),
}
