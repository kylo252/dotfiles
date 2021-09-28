local M = {}
M.config = {
  size = 40,
  open_mapping = [[<C-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = "float",
  close_on_exit = true, -- close the terminal window when the process exits
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
  },
}

M.setup = function()
  local terminal = require "toggleterm"
  terminal.setup(M.config)
end

M.execute_command = function(opts)
  opts.bin = opts.bin or opts.cmd

  if vim.fn.executable(opts.bin) ~= 1 then
    error(string.format("unable to find [%s].", opts.bin))
    return
  end
  local cmd = opts.bin .. " " .. table.concat(opts.args or {}, " ")
  opts.hidden = true
  opts.cmd = cmd

  local config = vim.tbl_deep_extend("force", M.config, opts)
  local Terminal = require("toggleterm.terminal").Terminal

  local request = Terminal:new(config)
  request:toggle()
end

M.toggle_lazygit = function()
  local opts = {
    open_mapping = "<leader>gg",
    cmd = "lazygit",
  }
  M.execute_command(opts)
end

M.toggle_explorer = function()
  local opts = {
    open_mapping = "<C-e>",
    bin = "lf",
  }
  M.execute_command(opts)
end

return M
