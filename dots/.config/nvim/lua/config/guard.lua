local ft = require('guard.filetype')

ft('typescript,javascript,typescriptreact'):fmt('prettier')

ft('html'):fmt('prettier')
ft('css'):fmt('prettier')

ft('python'):fmt('black')
    :lint('pylint')

require('guard').setup({
    -- the only options for the setup function
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = true,
})
