local clangd_flags = {
  "--all-scopes-completion",
  "--background-index",
  "--pch-storage=memory",
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
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
if status_ok then
  clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
end

return {
  cmd = { provider, unpack(clangd_flags) },
  on_attach = custom_on_attach,
}
