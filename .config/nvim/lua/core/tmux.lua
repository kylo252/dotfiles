local M = {}

function M.set_tmux_win_title(pattern)
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
  if not buftype or buftype == "nofile" or buftype == "quickfix" or buftype == "help" then
    return
  end
  local title = vim.fn.expand(pattern)
  vim.opt.titlestring = title
  local Job = require "plenary.job"
  Job:new({
    command = "tmux",
    args = { "rename-window", title },
  }):start()
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
      -- enables copy sync. by default, all registers are synchronized.
      -- to control which registers are synced, see the `sync_*` options.
      enable = false,

      -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
      -- first buffer or named_buffer_name = true to ignore a named tmux
      -- buffer with name named_buffer_name :)
      ignore_buffers = { empty = false },

      -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
      -- clipboard by tmux
      redirect_to_clipboard = false,

      -- offset controls where register sync starts
      -- e.g. offset 2 lets registers 0 and 1 untouched
      register_offset = 0,

      -- overwrites vim.g.clipboard to redirect * and + to the system
      -- clipboard using tmux. If you sync your system clipboard without tmux,
      -- disable this option!
      sync_clipboard = true,

      -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
      sync_registers = true,

      -- syncs deletes with tmux clipboard as well, it is adviced to
      -- do so. Nvim does not allow syncing registers 0 and 1 without
      -- overwriting the unnamed register. Thus, ddp would not be possible.
      sync_deletes = true,

      -- syncs the unnamed register with the first buffer entry from tmux.
      sync_unnamed = true,
    },
    resize = {
      -- enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = true,
    },
  }
end

return M
