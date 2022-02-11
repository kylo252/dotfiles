local M = {}

local opts = {
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 35,
  },
  respect_buf_cwd = 1,
  git_hl = 1,
  disable_window_picker = 1,
  root_folder_modifier = ":t",
}

function M.setup()
  local status_ok, _ = pcall(require, "nvim-tree")
  if not status_ok then
    error "failed to load nvim-tree.config"
    return
  end

  for opt, val in pairs(opts) do
    vim.g["nvim_tree_" .. opt] = val
  end

  vim.g.netrw_banner = 0

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
    auto_close = false,
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
          -- { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
          -- { key = "h", action = "close_node" },
          -- { key = "v", action = "vsplit" },
          -- { key = "C", action = "cd" },
          -- { key = "gtf", action_cb = "<cmd>lua require'lvim.core.nvimtree'.start_telescope('find_files')<cr>" },
          -- { key = "gtg", action_cb = "<cmd>lua require'lvim.core.nvimtree'.start_telescope('live_grep')<cr>" },
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = {},
    },
    actions = {
      change_dir = {
        global = false,
      },
      open_file = {
        quit_on_open = false,
      },
    },
    auto_open = false,
    tab_open = false,
  }

  require("nvim-tree").setup(setup_opts)
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
