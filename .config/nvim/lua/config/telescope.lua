local wk = require("which-key")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local themes = require("telescope.themes")
local trouble = require("trouble.providers.telescope")
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')

-- Dropdown list theme using a builtin theme definitions :
local custom_center_list_view = require'telescope.themes'.get_dropdown({
  -- winblend = 10,
  -- width = 0.5,
  prompt = ">> ",
  results_height = 15,
  previewer = false
})

-- Dropdown list theme using a builtin theme definitions :
local custom_center_list_view = require'telescope.themes'.get_dropdown({
  -- winblend = 10,
  -- width = 0.5,
  prompt = ">> ",
  results_height = 15,
  previewer = false
})

local custom_inline_list_view = require'telescope.themes'.get_ivy({
  -- winblend = 10,
  -- width = 0.5,
  previewer = false,
  sorting_strategy = "ascending",
  layout_strategy = "bottom_pane",
  layout_config = {height = 5},
  prompt = ">> "
})

-- Settings for with preview option
local custom_preview_list_view = require'telescope.themes'.get_dropdown({
  winblend = 10,
  show_line = false,
  prompt = ">>",
  results_title = false,
  preview_title = false,
  layout_config = {preview_width = 0.5}
})

vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>Telescope grep_string<CR>", {silent = true, noremap = true})

local keymap = {
  E = {"<cmd>lua require\"config.telescope\".scope_browser()<CR>", "Open scope browser"},
  f = {
    name = "+Find",
    b = {"<cmd>Telescope buffers<CR>", "buffers"},
    F = {"<cmd>lua require\"config.telescope\".find_project_files()<CR>", "Open project files"},
    G = {"<cmd>lua require\"config.telescope\".grep_project_files()<CR>", "Grep project files"},
    h = {"<cmd>Telescope help_tags<CR>", "help tags"},
    M = {"<cmd>Telescope man_pages<CR>", "Man Pages"},
    R = {"<cmd>Telescope registers<CR>", "Registers"},
    c = {"<cmd>Telescope colorscheme<CR>", "Colorscheme"},
    f = {"<cmd>Telescope find_files<CR>", "Find Files"},
    g = {"<cmd>Telescope live_grep<CR>", "Live Grep"},
    m = {"<cmd>Telescope marks<CR>", "Marks"},
    p = {"<cmd>Telescope git_files<CR>", "Find Project Files"},
    r = {"<cmd>Telescope oldfiles<CR>", "Open Recent File"},
    d = {
      name = "+dotfiles",
      d = {"<cmd>lua require\"config.telescope\".find_dotfiles()<CR>", "Open dotfiles"},
      s = {"<cmd>edit ~/.config/nvim/lua/settings.lua<cr>", "Edit nvim settings"},
      p = {"<cmd>edit ~/.config/nvim/lua/settings.lua<cr>", "Edit Packer plugins"}
    }
  },
  c = {
    name = "+commands",
    c = {"<cmd>Telescope commands<CR>", "commands"},
    h = {"<cmd>Telescope command_history<CR>", "history"}
  },
  g = {
    name = "+git",
    g = {"<cmd>Telescope git_commits<CR>", "commits"},
    c = {"<cmd>Telescope git_bcommits<CR>", "bcommits"},
    b = {"<cmd>Telescope git_branches<CR>", "branches"},
    s = {"<cmd>Telescope git_status<CR>", "status"}
  }
}

wk.register(keymap, {prefix = "<leader>", silent = true, noremap = true})

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {"rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case"},
    find_command = {"rg", "--no-heading", "--with-filename", "--hidden", "--line-number", "--column", "--smart-case"},
    shorten_path = true,
    -- border = {},
    set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<S-Up>"] = actions.preview_scrolling_up,
        ["<S-Down>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-s>"] = trouble.open_with_trouble
        -- ["<C-i>"] = my_cool_custom_action,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<S-Up>"] = actions.preview_scrolling_up,
        ["<S-Down>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-s>"] = trouble.open_with_trouble
        -- ["<C-i>"] = my_cool_custom_action,
      }
    }
  },
  extensions = {fzf = {override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case"}}
}
require("telescope").load_extension("fzf")

local _M = {}
--[[
	call via:
	:lua require"telescope-config".edit_neovim()

	example keymap:
	vim.api.nvim_set_keymap("n", "<Leader>nn", "<CMD>lua require\"telescope-config\".edit_neovim()<CR>", {noremap = true, silent = true})
--]]
function _M.grep_neovim_dotfiles()
  require("telescope.builtin").live_grep {search_dirs = "~/.config/nvim", hidden = true}
end

function _M.find_dotfiles()
  local _opts = vim.deepcopy(custom_inline_list_view)
  _opts.prompt_title = "~ dotfiles ~"
  _opts.cwd = "~"
  _opts.find_command = {"git", "dots", "ls-files"}
  -- _opts.layout_strategy = "flex"
  require'telescope.builtin'.find_files(_opts)
end

function _M.find_project_files()
  local _opts = vim.deepcopy(custom_center_list_view)
  local ok = pcall(require"telescope.builtin".git_files, _opts)
  if not ok then require"telescope.builtin".find_files(_opts) end
end

function _M.scope_browser()
  local _opts = vim.deepcopy(custom_preview_list_view)
  require"telescope.builtin".file_browser(_opts)
end

function _M.grep_project_files()
  local _opts = vim.deepcopy(custom_center_list_view)
  require"telescope.builtin".grep_string(_opts)
end
return _M

