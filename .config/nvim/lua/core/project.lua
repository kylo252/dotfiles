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

    -- What scope to change the directory, valid options are
    -- * global (default)
    -- * tab
    -- * win
    scope_chdir = "win",

    -- Don't calculate root dir on specific directories
    -- Ex: { "~/.cargo/*", ... }
    exclude_dirs = {},
  }

  require("project_nvim").setup(opts)
end

return M
