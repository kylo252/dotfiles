local clangd_flags = {
  "--background-index",
  "--header-insertion=never",
  "--cross-file-rename",
  "--clang-tidy",
  "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
}

local provider = "clangd"

if vim.fn.executable(provider) ~= 1 then
  provider = DATA_PATH .. "/lspinstall/cpp/clangd/bin/" .. provider
end

local custom_on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

return {
  cmd = { provider, unpack(clangd_flags) },
  on_attach = custom_on_attach,
}
