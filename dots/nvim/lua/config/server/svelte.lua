return {
    cmd = { "svelteserver", "--stdio" },
    filetypes = { "svelte" },
    root_dir = require('lspconfig.util').root_pattern("package.json", ".git"),
}
