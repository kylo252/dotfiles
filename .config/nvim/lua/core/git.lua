local M = {}

function M.setup_gitsigns()
  require("gitsigns").setup {
    signs = {
      add = { hl = "GitSignsAdd", text = "│" },
      change = { hl = "GitSignsChange", text = "│" },
      delete = { hl = "GitSignsDelete", text = "_" },
      topdelete = { hl = "GitSignsDelete", text = "‾" },
      changedelete = { hl = "GitSignsChange", text = "~" },
    },
    sign_priority = 10000,
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,

      ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
      ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

      -- Text objects
      ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    },
  }
end

function M.setup_gitlinker()
  local gitlinker = require "gitlinker"
  local hosts = require("gitlinker").hosts

  local get_gerrit_gitlies_type_url = function(url_data)
    local url = "https://" .. url_data.host .. "/plugins/gitiles/" .. url_data.repo
    if not url_data.file or not url_data.rev then
      return url
    end
    url = url .. "/+/" .. url_data.rev .. "/" .. url_data.file
    if not url_data.lstart then
      return url
    end
    url = url .. "#" .. url_data.lstart
    return url
  end

  gitlinker.setup {
    callbacks = {
      ["github.com"] = hosts.get_github_type_url,
      ["gerrit"] = get_gerrit_gitlies_type_url,
    },
  }
end

function M.get_blame_url()
  local repo_url = require("gitlinker").get_repo_url { print_url = false }

  local win_id = vim.api.nvim_get_current_win()
  local cur_pos = vim.api.nvim_win_get_cursor(win_id)
  local filename = vim.fn.expand "%"
  local repo = require("lspconfig.util").find_git_ancestor(vim.fn.expand "%:p")
  local lnum = cur_pos[1] + 1
  local args = { "log", "-L" .. lnum .. "," .. lnum + 1 .. ":" .. filename, "--pretty=%H", "--no-patch" }
  local job = require("plenary.job"):new { command = "git", args = args, cwd = repo }
  local commit_url
  job:after_success(function(this_job)
    local commit_sha = this_job:result()[1]
    commit_url = repo_url .. "/commit/" .. commit_sha
    vim.schedule(function()
      vim.notify(commit_url, vim.log.levels.INFO, { title = "commit url" })
      vim.fn.setreg("+", commit_url)
    end)
  end)
  job:start()
end

function M.setup_diffview()
  -- Lua
  local cb = require("diffview.config").diffview_callback

  require("diffview").setup {
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
    use_icons = true, -- Requires nvim-web-devicons
    icons = { -- Only applies when use_icons is true.
      folder_closed = "",
      folder_open = "",
    },
    signs = {
      fold_closed = "",
      fold_open = "",
    },
    file_panel = {
      position = "left", -- One of 'left', 'right', 'top', 'bottom'
      width = 35, -- Only applies when position is 'left' or 'right'
      height = 10, -- Only applies when position is 'top' or 'bottom'
      listing_style = "tree", -- One of 'list' or 'tree'
      tree_options = { -- Only applies when listing_style is 'tree'
        flatten_dirs = true, -- Flatten dirs that only contain one single dir
        folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
      },
    },
    file_history_panel = {
      position = "bottom",
      width = 35,
      height = 16,
      log_options = {
        max_count = 256, -- Limit the number of commits
        follow = false, -- Follow renames (only for single file)
        all = false, -- Include all refs under 'refs/' including HEAD
        merges = false, -- List only merge commits
        no_merges = false, -- List no merge commits
        reverse = false, -- List commits in reverse order
      },
    },
    default_args = { -- Default args prepended to the arg-list for the listed commands
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {}, -- See ':h diffview-config-hooks'
    key_bindings = {
      disable_defaults = false, -- Disable the default key bindings
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      view = {
        ["<tab>"] = cb "select_next_entry", -- Open the diff for the next file
        ["<s-tab>"] = cb "select_prev_entry", -- Open the diff for the previous file
        ["gf"] = cb "goto_file", -- Open the file in a new split in previous tabpage
        ["<C-w><C-f>"] = cb "goto_file_split", -- Open the file in a new split
        ["<C-w>gf"] = cb "goto_file_tab", -- Open the file in a new tabpage
        ["<leader>e"] = cb "focus_files", -- Bring focus to the files panel
        ["<leader>b"] = cb "toggle_files", -- Toggle the files panel.
      },
      file_panel = {
        ["j"] = cb "next_entry", -- Bring the cursor to the next file entry
        ["<down>"] = cb "next_entry",
        ["k"] = cb "prev_entry", -- Bring the cursor to the previous file entry.
        ["<up>"] = cb "prev_entry",
        ["<cr>"] = cb "select_entry", -- Open the diff for the selected entry.
        ["o"] = cb "select_entry",
        ["<2-LeftMouse>"] = cb "select_entry",
        ["-"] = cb "toggle_stage_entry", -- Stage / unstage the selected entry.
        ["S"] = cb "stage_all", -- Stage all entries.
        ["U"] = cb "unstage_all", -- Unstage all entries.
        ["X"] = cb "restore_entry", -- Restore entry to the state on the left side.
        ["R"] = cb "refresh_files", -- Update stats and entries in the file list.
        ["<tab>"] = cb "select_next_entry",
        ["<s-tab>"] = cb "select_prev_entry",
        ["gf"] = cb "goto_file",
        ["<C-w><C-f>"] = cb "goto_file_split",
        ["<C-w>gf"] = cb "goto_file_tab",
        ["i"] = cb "listing_style", -- Toggle between 'list' and 'tree' views
        ["f"] = cb "toggle_flatten_dirs", -- Flatten empty subdirectories in tree listing style.
        ["<leader>e"] = cb "focus_files",
        ["<leader>b"] = cb "toggle_files",
      },
      file_history_panel = {
        ["g!"] = cb "options", -- Open the option panel
        ["<C-A-d>"] = cb "open_in_diffview", -- Open the entry under the cursor in a diffview
        ["y"] = cb "copy_hash", -- Copy the commit hash of the entry under the cursor
        ["zR"] = cb "open_all_folds",
        ["zM"] = cb "close_all_folds",
        ["j"] = cb "next_entry",
        ["<down>"] = cb "next_entry",
        ["k"] = cb "prev_entry",
        ["<up>"] = cb "prev_entry",
        ["<cr>"] = cb "select_entry",
        ["o"] = cb "select_entry",
        ["<2-LeftMouse>"] = cb "select_entry",
        ["<tab>"] = cb "select_next_entry",
        ["<s-tab>"] = cb "select_prev_entry",
        ["gf"] = cb "goto_file",
        ["<C-w><C-f>"] = cb "goto_file_split",
        ["<C-w>gf"] = cb "goto_file_tab",
        ["<leader>e"] = cb "focus_files",
        ["<leader>b"] = cb "toggle_files",
      },
      option_panel = {
        ["<tab>"] = cb "select",
        ["q"] = cb "close",
      },
    },
  }
end

return M
