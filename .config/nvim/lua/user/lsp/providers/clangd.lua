local clangd_flags = {
  "--all-scopes-completion",
  "--background-index",
  "--log=error",
  "--pretty",
  "--enable-config",
  "--clang-tidy",
  "--completion-style=detailed",
  -- "-j8",
  "--offset-encoding=utf-16", --temporary fix for null-ls
  "--query-driver=/bin/*-gcc,/bin/*-g++,/bin/clang-*", -- allow cross-compilers
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
  vim.keymap.set("n", "<leader>ll", "<cmd>ClangdToggleInlayHints<cr>", opts)
  vim.keymap.set("n", "<leader>lm", "<cmd>ClangdMemoryUsage<cr>", opts)
end

local util = require "lspconfig.util"
local root_files = {
  -- ".clangd",  -- can be included in subdirs
  -- ".clang-tidy",
  -- ".clang-format",
  "compile_commands.json",
  "compile_flags.txt",
  "configure.ac", -- AutoTools
}

local server_opts = {
  cmd = { provider, unpack(clangd_flags) },
  on_attach = custom_on_attach,
  root_dir = function(fname)
    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
  end,
}

return server_opts
