local M = {}

local opts = {
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 35,
  },
  quit_on_open = 0,
  respect_buf_cwd = 1,
  git_hl = 1,
  disable_window_picker = 0,
  root_folder_modifier = ":t",
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
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
      "startify",
      "dashboard",
      "alpha",
    },
    update_to_buf_dir = {
      enable = true,
      auto_open = true,
    },
    auto_close = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    diagnostics = nil,
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    system_open = {
      cmd = nil,
      args = {},
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 200,
    },
    view = {
      width = 30,
      height = 30,
      side = "left",
      auto_resize = true,
      number = false,
      relativenumber = false,
      mappings = {
        custom_only = false,
        list = {
          { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
          { key = "h", cb = tree_cb "close_node" },
          { key = "h", cb = tree_cb "close_node" },
          { key = "C", cb = tree_cb "cd" },
          { key = "gtf", cb = "<cmd>lua require'core.nvimtree'.start_telescope('find_files')<cr>" },
          { key = "gtg", cb = "<cmd>lua require'core.nvimtree'.start_telescope('live_grep')<cr>" },
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { ".git", "node_modules", ".cache" },
    },
    auto_open = false,
    tab_open = false,
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

function M.start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode] {
    cwd = basedir,
  }
end

return M
