local M = {}

function M.setup()
  local opts = {
    -- directory where session files are saved
    dir = vim.fn.expand(vim.fn.stdpath "cache" .. "/nvim_sessions/"),
    -- sessionoptions used for saving
    options = { "buffers", "curdir", "tabpages", "winsize" },
  }
  require("persistence").setup(opts)
end

return M
