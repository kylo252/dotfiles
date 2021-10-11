local M = {}

local function get_tmux()
  return os.getenv "TMUX"
end

local function get_socket()
  return vim.split(get_tmux(), ",")[1]
end

local function execute(arg, pre)
  local command = string.format("%s tmux -S %s %s", pre or "", get_socket(), arg)

  local handle = assert(io.popen(command), string.format("unable to execute: [%s]", command))
  local result = handle:read "*a"
  handle:close()

  return result
end

function M.set_tmux_win_title(pattern)
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
  if not buftype or buftype == "nofile" or buftype == "quickfix" or buftype == "help" then
    return
  end
  local title = vim.fn.expand(pattern)
  vim.opt.titlestring = title
  local Job = require "plenary.job"
  Job
    :new({
      command = "tmux",
      args = { "rename-window", title },
    })
    :start()
end

function M.set_tmux_win_title_native(pattern)
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
  print(vim.inspect("got buftype: " .. buftype))
  if not buftype or buftype == "nofile" or buftype == "quickfix" or buftype == "help" then
    return
  end
  local title = vim.fn.expand(pattern)
  local cmd = string.format("tmux rename-window %q", title)
  execute(cmd)
end

function M.setup()
  require("tmux").setup {
    navigation = {
      -- cycles to opposite pane while navigating into the border
      cycle_navigation = true,

      -- enables default keybindings (C-hjkl) for normal mode
      enable_default_keybindings = true,

      -- prevents unzoom tmux when navigating beyond vim border
      persist_zoom = true,
    },
    copy_sync = {
      -- enables copy sync and overwrites all register actions to
      -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
      enable = false,
    },
    resize = {
      -- enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = true,
    },
  }
end

return M
