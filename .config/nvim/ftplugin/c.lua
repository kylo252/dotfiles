local clangd_flags = {
      "--background-index",
      "--header-insertion=never",
      "--cross-file-rename",
      "--clang-tidy",
      "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*"
}

require("lspconfig").clangd.setup {
  cmd = {DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd",  unpack(clangd_flags)},
  -- cmd = { "clangd", unpack(clangd_flags) },
  on_attach = require("lsp").common_on_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      --[[ virtual_text = O.lang.clang.diagnostics.virtual_text,
      signs = O.lang.clang.diagnostics.signs,
      underline = O.lang.clang.diagnostics.underline, ]]
      update_in_insert = true,
    }),
  },
}

--require("lsp.efm-general-ls").generic_setup({"c", "cpp"})
