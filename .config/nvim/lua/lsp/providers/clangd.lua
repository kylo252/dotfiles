local clangd_flags = {
  "--all-scopes-completion",
  "--suggest-missing-includes",
  "--background-index",
  "--pch-storage=disk",
  "--cross-file-rename",
  "--log=info",
  "--enable-config",
  "--clang-tidy",
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
}

local provider = "clangd"

local custom_on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local rhel_config = os.getenv "RHEL_CONFIG_HOME"
if rhel_config then
  vim.opt.rtp:append(rhel_config)
  local project_config = require("clangd_wrs")
  clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
end

return {
  cmd = { provider, unpack(clangd_flags) },
  on_attach = custom_on_attach,
}
