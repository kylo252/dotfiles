local wk = require "which-key"

local actions = require "telescope.actions"
local themes = require "telescope.themes"
local trouble = require "trouble.providers.telescope"

-- Dropdown list theme using a builtin theme definitions :
local center_list_w_preview = themes.get_dropdown {
  -- winblend = 10,
  -- width = 0.5,
  prompt = ">> ",
  results_height = 15,
  previewer = true,
}

-- Dropdown list theme using a builtin theme definitions :
local center_list = themes.get_dropdown {
  -- winblend = 10,
  -- width = 0.5,
  prompt = ">> ",
  results_height = 15,
  previewer = false,
}

local inline_list = themes.get_ivy {
  -- winblend = 10,
  -- width = 0.5,
  previewer = false,
  sorting_strategy = "ascending",
  layout_strategy = "bottom_pane",
  layout_config = { height = 5 },
  prompt = ">> ",
}

-- Settings for with preview option
local files_list_w_preview = themes.get_dropdown {
  winblend = 10,
  prompt_position = "top",
  show_line = false,
  prompt = ">>",
  results_title = "\\ Files //",
  preview_title = false,
  layout_strategy = "flex",
  layout_config = { preview_width = 0.5 },
}

require("telescope").setup {
  defaults = {
    vimgrep_arguments = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
    find_command = { "rg", "--no-heading", "--with-filename", "--hidden", "--line-number", "--column", "--smart-case" },
    -- border = {},
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<S-Up>"] = actions.preview_scrolling_up,
        ["<S-Down>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-s>"] = trouble.open_with_trouble,
        -- ["<C-i>"] = my_cool_custom_action,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<S-Up>"] = actions.preview_scrolling_up,
        ["<S-Down>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-s>"] = trouble.open_with_trouble,
        -- ["<C-i>"] = my_cool_custom_action,
      },
    },
  },
  extensions = {
    fzf = { override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
    --[[ frecency = {
      show_scores = false,
      show_unindexed = true,
      show_fiter_column = true,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
      workspaces = {
        ["nvim"] = os.getenv("HOME") .. "/.config/nvim",
        ["zsh"] = os.getenv("HOME") .. "/.config/zsh",
        ["config"] = os.getenv("HOME") .. "/.config",
        ["data"] = os.getenv("HOME") .. "/.local/share",
      }
    } ]]
  },
}

require("telescope").load_extension "fzf"
-- require("telescope").load_extension("session-lens")
-- require("telescope").load_extension("frecency")

local _M = {}
--[[
	call via:
	:lua require"telescope-config".edit_neovim()

	example keymap:
	vim.api.nvim_set_keymap("n", "<Leader>nn", "<CMD>lua require\"telescope-config\".edit_neovim()<CR>", {noremap = true, silent = true})
--]]
function _M.grep_neovim_dotfiles()
  require("telescope.builtin").live_grep { search_dirs = "~/.config/nvim", hidden = true }
end

function _M.open_recent()
  local _opts = vim.deepcopy(center_list)
  require("telescope").extensions.frecency.frecency(_opts)
end

function _M.find_dotfiles()
  local _opts = vim.deepcopy(inline_list)
  _opts.prompt_title = "~ dotfiles ~"
  _opts.cwd = "~"
  _opts.find_command = { "git", "dots", "ls-files" }
  -- _opts.layout_strategy = "flex"
  require("telescope.builtin").find_files(_opts)
end

function _M.find_project_files()
  local _opts = vim.deepcopy(center_list_w_preview)
  local ok = pcall(require("telescope.builtin").git_files, _opts)
  if not ok then
    require("telescope.builtin").find_files(_opts)
  end
end

function _M.grep_project_files()
  local _opts = vim.deepcopy(center_list_w_preview)
  require("telescope.builtin").grep_string(_opts)
end

function _M.scope_browser()
  require("telescope.builtin").file_browser {
    layout_config = { preview_width = 0.7 },
    layout_strategy = "horizontal",
    preview_title = false,
    hidden = false,
    prompt_position = "top",
    sorting_strategy = "ascending",
    prompt_title = " File Browser",
    results_title = false,
    shorten_path = smart,
    show_line = false,
    width = 0.15,
    winblend = 10,
  }
end

return _M
