local M = {}

function M.setup()
  local opts = {
    manual_mode = false,

    detection_methods = { "lsp", "pattern" },

    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

    show_hidden = true,

    silent_chdir = true,

    ignore_lsp = {},

    datapath = vim.fn.stdpath "cache",
  }

  require("project_nvim").setup(opts)
end

return M
