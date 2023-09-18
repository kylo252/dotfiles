local M = {}

local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  local function telescope_find_files(_)
    require("core.nvimtree").start_telescope "find_files"
  end

  local function telescope_live_grep(_)
    require("core.nvimtree").start_telescope "live_grep"
  end

  api.config.mappings.default_on_attach(bufnr)

  local useful_keys = {
    ["l"] = { api.node.open.edit, opts "Open" },
    ["o"] = { api.node.open.edit, opts "Open" },
    ["<CR>"] = { api.node.open.edit, opts "Open" },
    ["v"] = { api.node.open.vertical, opts "Open: Vertical Split" },
    ["h"] = { api.node.navigate.parent_close, opts "Close Directory" },
    ["C"] = { api.tree.change_root_to_node, opts "CD" },
    ["gtg"] = { telescope_live_grep, opts "Telescope Live Grep" },
    ["gtf"] = { telescope_find_files, opts "Telescope Find File" },
  }

  require("user.keymaps").load_mode("n", useful_keys)
end

function M.setup()
  local status_ok, _ = pcall(require, "nvim-tree")
  if not status_ok then
    error "failed to load nvim-tree.config"
    return
  end

  local setup_opts = {
    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    -- ignore_buffer_on_setup = false,
    ignore_buf_on_tab_change = {},
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = true,
    reload_on_bufenter = false,
    respect_buf_cwd = true,
    select_prompts = false,
    update_focused_file = {
      enable = true,
      update_root = true, -- maybe replace with fs_event
      ignore_list = {},
    },
    hijack_directories = {
      -- kyazdani42/nvim-tree.lua#1363
      enable = false,
    },
    system_open = {
      cmd = nil,
      args = {},
    },
    notify = {
      threshold = vim.log.levels.INFO,
    },
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      timeout = 200,
    },
    on_attach = on_attach,
    view = {
      adaptive_size = false,
      hide_root_folder = false,
      centralize_selection = true,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
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
      exclude = {},
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = false,
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
        close_window = true,
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
