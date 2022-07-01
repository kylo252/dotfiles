local M = {}

function M.setup()
  local status_ok, _ = pcall(require, "nvim-tree")
  if not status_ok then
    error "failed to load nvim-tree.config"
    return
  end

  vim.g.netrw_banner = 0

  local function telescope_find_files(_)
    require("core.nvimtree").start_telescope "find_files"
  end

  local function telescope_find_str(_)
    require("core.nvimtree").start_telescope "live_grep"
  end

  local setup_opts = {
    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = true,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = false,
    sort_by = "name",
    reload_on_bufenter = false,
    update_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = {},
    },
    ignore_ft_on_setup = {
      "alpha",
    },
    hijack_directories = {
      -- kyazdani42/nvim-tree.lua#1363
      enable = false,
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
      adaptive_size = false,
      hide_root_folder = false,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      mappings = {
        custom_only = false,
        list = {
          { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
          { key = "h", action = "close_node" },
          { key = "v", action = "vsplit" },
          { key = "C", action = "cd" },
          { key = "tf", action = "find_files", action_cb = telescope_find_files },
          { key = "tg", action = "grep_string", action_cb = telescope_find_str },
        },
      },
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      highlight_git = false,
      highlight_opened_files = "none",
      root_folder_modifier = ":~",
      indent_markers = {
        enable = false,
        icons = {},
      },
      icons = {
        webdev_colors = true,
        git_placement = "before",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {},
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    },
    filters = {
      dotfiles = false,
      custom = {},
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
      },
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = false,
        },
      },
      remove_file = {
        close_window = false,
      },
    },
    diagnostics = nil,
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true, -- this gets confusing otherwise
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        diagnostics = false,
        git = false,
        profile = false,
      },
    },
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
