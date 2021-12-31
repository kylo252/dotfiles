local M = {}

local config = {
  size = 20,
  open_mapping = [[<C-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = false,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = "float",
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = "single",
    -- width = <value>,
    -- height = <value>,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
    winblend = 0,
  },
  execs = {
    { "lazygit", "<leader>gg", "LazyGit", "float" },
    { "lazygit", "<c-\\><c-g>", "LazyGit", "float" },
    { "lazygit --git-dir=$HOME/.dtf.git --work-tree=$HOME", "<leader>gd", "LazyDots", "float" },
    { "lf", "<c-e>", "lf", "float" },
  },
}

M.setup = function()
  local terminal = require "toggleterm"
  terminal.setup(config)
  -- setup the default terminal so it's always reachable
  local default_term_opts = {
    cmd = config.shell,
    keymap = config.open_mapping,
    label = "terminal",
    count = 1,
    direction = "horizontal",
    size = config.size,
  }

  M.add_exec(default_term_opts)

  for i, exec in pairs(config.execs) do
    local opts = {
      cmd = exec[1],
      keymap = exec[2],
      label = exec[3],
      count = i + 1,
      direction = exec[4] or config.direction,
      size = config.size,
    }

    M.add_exec(opts)
  end
end

M.add_exec = function(opts)
  local binary = opts.cmd:match "(%S+)"
  if vim.fn.executable(binary) ~= 1 then
    return
  end

  local exec_func = string.format(
    "<cmd>lua require('core.terminal')._exec_toggle({ cmd = '%s', count = %d, direction = '%s'})<CR>",
    opts.cmd,
    opts.count,
    opts.direction
  )

  require("keymappings").load {
    normal_mode = { [opts.keymap] = exec_func },
    term_mode = { [opts.keymap] = exec_func },
  }

  local wk_status_ok, wk = pcall(require, "whichkey")
  if not wk_status_ok then
    return
  end
  wk.register({ [opts.keymap] = { opts.label } }, { mode = "n" })
  wk.register({ [opts.keymap] = { opts.label } }, { mode = "t" })
end

M._exec_toggle = function(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction }
  term:toggle(opts.size or config.size, opts.direction)
end

return M
