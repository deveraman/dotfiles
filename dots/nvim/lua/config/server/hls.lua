return {
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    root_dir = require('lspconfig.util').root_pattern("hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml"),
    settings = {
	  haskell = {
	    cabalFormattingProvider = "cabalfmt",
	    formattingProvider = "ormolu"
	  }
    },
    single_file_support = true
}
