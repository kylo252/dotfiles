local function get_hover_info()
  local ts_utils = require "nvim-treesitter.ts_utils"
  local n = ts_utils.get_node_at_cursor()
  local type = n:type()
  if type ~= "identifier" then
    n = n:parent()
  end
  local text = vim.treesitter.query.get_node_text(n, 0)

  local cmd = string.format("cmake --help-command %s | bat --plain -l rst", text)
  local Terminal = require("toggleterm.terminal").Terminal
  local term_opts = { cmd = cmd, direction = "horizontal" }
  local cmake_help = Terminal:new(term_opts)

  cmake_help:toggle()
end

local custom_on_attach = function(client, bufnr)
  require("user.lsp").common_on_attach(client, bufnr)

  local opts = { noremap = true, silent = true, buffer = bufnr, desc = "Hover info" }
  vim.keymap.set("n", "<leader>lh", get_hover_info, opts)
end

return {
  -- autostart = false,
  on_attach = custom_on_attach,
}
