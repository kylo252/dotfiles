local M = {}

local opts = {
  side = "left",
  setup = {
    auto_open = 0,
    auto_close = 1,
    tab_open = 0,
    update_focused_file = {
      enable = 1,
    },
    lsp_diagnostics = 1,
  },
  width = 30,
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  },
  ignore = { ".git", "node_modules", ".cache" },
  quit_on_open = 0,
  hide_dotfiles = 0,
  git_hl = 1,
  root_folder_modifier = ":t",
  allow_resize = 1,
  auto_ignore_ft = { "startify", "dashboard" },
}

function M.setup()
  local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
  if not status_ok then
    return
  end
  local g = vim.g

  for opt, val in pairs(opts) do
    g["nvim_tree_" .. opt] = val
  end

  -- Implicitly update nvim-tree when project module is active
  opts.respect_buf_cwd = 1
  opts.setup.update_cwd = 1
  opts.setup.disable_netrw = 0
  opts.setup.hijack_netrw = 0
  vim.g.netrw_banner = 0

  local tree_cb = nvim_tree_config.nvim_tree_callback

  if not opts.bindings then
    opts.bindings = {
      { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
      { key = "h", cb = tree_cb "close_node" },
    }
  end

  require("nvim-tree").setup(opts)
end

M.toggle_tree = function()
  local view = require "nvim-tree.view"
  if view.win_open() then
    require("nvim-tree").close()
    require("bufferline.state").set_offset(0)
  else
    require("bufferline.state").set_offset(31, "")
    require("nvim-tree").find_file(true)
  end
end

return M
