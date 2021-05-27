-- If you are using rvm, make sure to change below configuration
require'lspconfig'.solargraph.setup {
    cmd = { DATA_PATH .. "~/.rbenv/shims/solargraph", "--stdio" },
    on_attach = require'lsp'.common_on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            signs = true,
            underline = true,
            update_in_insert = true

        })
    }
}
