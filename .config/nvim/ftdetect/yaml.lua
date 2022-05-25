vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = ".clang*", command = "set filetype=yaml" }
)
