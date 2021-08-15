local M = {}
M.config = {
  -- size can be a number or function which is passed the current terminal
  size = 5,
  -- open_mapping = [[<c-\>]],
  open_mapping = [[<c-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
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
    border = "curved",
    -- width = <value>,
    -- height = <value>,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

M.setup = function()
  local terminal = require("toggleterm")
  terminal.setup(M.config)
end

M.execute_command = function(opts)
  local cmd = opts.bin
  if opts.args and not vim.tbl_isempty(opts.args) then
    cmd = cmd .. " " .. table.concat(opts.args, " ")
  end
  if vim.fn.executable(opts.bin) ~= 1 then
    error(string.format("unable to find [%s].", bin))
    return
  end

  local Terminal = require("toggleterm.terminal").Terminal
  print(vim.inspect(cmd))
  local request = Terminal:new({ cmd = cmd, hidden = true })
  request:toggle()
end

return M
