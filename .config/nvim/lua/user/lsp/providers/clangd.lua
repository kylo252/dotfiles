local clangd_flags = {
  "--all-scopes-completion",
  "--background-index",
  "--suggest-missing-includes",
  -- "--pch-storage=disk",
  "--log=info",
  "--enable-config",
  "--clang-tidy",
  "--completion-style=detailed",
  "--offset-encoding=utf-16", --temporary fix for null-ls
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

  require("clangd_extensions.inlay_hints").setup_autocmd()
  require("clangd_extensions.inlay_hints").set_inlay_hints()
end

local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
if status_ok then
  clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
end

local custom_on_init = function(client, bufnr)
  require("user.lsp").common_on_init(client, bufnr)
  require("clangd_extensions.config").setup {}
  -- Set up AST state stuff
  require("clangd_extensions.ast").init()

  vim.cmd [[
  command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
  command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
  command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
  command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
  command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
  ]]
end

return {
  cmd = { provider, unpack(clangd_flags) },
  on_attach = custom_on_attach,
  on_init = custom_on_init,
}
