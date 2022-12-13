local clangd_flags = {
  "--all-scopes-completion",
  "--background-index",
  "--log=info",
  "--enable-config",
  "--clang-tidy",
  "--completion-style=detailed",
  "--offset-encoding=utf-16", --temporary fix for null-ls
  -- "--pch-storage=disk",
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
}

local provider = "clangd"

local custom_on_attach = function(client, bufnr)
  require("user.lsp").common_on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
  vim.keymap.set("x", "<leader>lA", "<cmd>ClangdAST<cr>", opts)
  vim.keymap.set("n", "<leader>lH", "<cmd>ClangdTypeHierarchy<cr>", opts)
  vim.keymap.set("n", "<leader>lt", "<cmd>ClangdSymbolInfo<cr>", opts)
  vim.keymap.set("n", "<leader>lm", "<cmd>ClangdMemoryUsage<cr>", opts)
end

local server_opts = {
  cmd = { provider, unpack(clangd_flags) },
  on_attach = custom_on_attach,
}

return require("clangd_extensions").prepare { server = server_opts }
