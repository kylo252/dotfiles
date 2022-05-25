vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "Jenkinsfile", "*.dsl" }, command = "set filetype=groovy" }
)
