-- npm i -g bash-language-server
require'lspconfig'.bashls.setup {
    cmd = {DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server", "start"},
    on_attach = require'lsp'.common_on_attach,
    filetypes = { "sh", "bash"}
}

require"lspconfig".efm.setup {
    cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {"sh", "bash"},
}
