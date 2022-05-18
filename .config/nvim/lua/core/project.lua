local M = {}

function M.setup()
  local opts = {
    manual_mode = false,

    detection_methods = { "lsp", "pattern" },

    patterns = { ".git" },

    show_hidden = true,

    silent_chdir = true,

    ignore_lsp = { "null-ls" },

    datapath = vim.fn.stdpath "cache",
  }

  require("project_nvim").setup(opts)
end

return M
