require'lspconfig'.clangd.setup {
    cmd = {"/app/vbuild/RHEL7-x86_64/clang/11.0.0/bin/clangd"},
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
