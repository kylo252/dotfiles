local clangd_flags = {"--enable-config"};

require'lspconfig'.clangd.setup {
    -- cmd = {DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd",  unpack(clangd_flags)},
    cmd = {"clangd",  unpack(clangd_flags)},
    on_attach = require'lsp'.common_on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = O.lang.clang.diagnostics.virtual_text,
            signs = O.lang.clang.diagnostics.signs,
            underline = O.lang.clang.diagnostics.underline,
            update_in_insert = true

        })
    }
}
