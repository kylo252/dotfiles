local M = {}

local opts = {
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 35,
  },
  ignore = { ".git", "node_modules", ".cache" },
  quit_on_open = 0,
  respect_buf_cwd = 1,
  hide_dotfiles = 0,
  git_hl = 1,
  root_folder_modifier = ":t",
  allow_resize = 1,
  auto_ignore_ft = { "startify", "dashboard" },
}

function M.setup()
  local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
  if not status_ok then
    error "failed to load nvim-tree.config"
    return
  end

  for opt, val in pairs(opts) do
    vim.g["nvim_tree_" .. opt] = val
  end

  vim.g.netrw_banner = 0

  local tree_cb = nvim_tree_config.nvim_tree_callback

  local setup_opts = {
    auto_open = false,
    auto_close = true,
    tab_open = false,
    update_cwd = true,
    disable_netrw = false,
    hijack_netrw = false,
    update_focused_file = {
      enable = true,
    },
    diagnostics = nil,
    view = {
      width = 30,
      side = "left",
      auto_resize = false,
      mappings = {
        custom_only = false,
        list = {
          { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
          { key = "h", cb = tree_cb "close_node" },
        },
      },
    },
  }

  -- Add nvim_tree open callback
  local tree_view = require "nvim-tree.view"
  local open = tree_view.open
  tree_view.open = function()
    M.on_open()
    open()
  end

  vim.cmd "au WinClosed * lua require('core.nvimtree').on_close()"

  require("nvim-tree").setup(setup_opts)
end

function M.on_open()
  if package.loaded["bufferline.state"] then
    require("bufferline.state").set_offset(35, "")
  end
end

function M.on_close()
  local buf = tonumber(vim.fn.expand "<abuf>")
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  if ft == "NvimTree" and package.loaded["bufferline.state"] then
    require("bufferline.state").set_offset(0)
  end
end

function M.change_tree_dir(dir)
  local lib_status_ok, lib = pcall(require, "nvim-tree.lib")
  if lib_status_ok then
    lib.change_dir(dir)
  end
end

return M
