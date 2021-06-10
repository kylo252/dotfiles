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
local center_list_w_preview = themes.get_dropdown({
  -- winblend = 10,
  -- width = 0.5,
  prompt = ">> ",
  results_height = 15,
  previewer = true
})

-- Dropdown list theme using a builtin theme definitions :
local center_list = themes.get_dropdown({
  -- winblend = 10,
  -- width = 0.5,
  prompt = ">> ",
  results_height = 15,
  previewer = false
})

local inline_list = themes.get_ivy({
  -- winblend = 10,
  -- width = 0.5,
  previewer = false,
  sorting_strategy = "ascending",
  layout_strategy = "bottom_pane",
  layout_config = {height = 5},
  prompt = ">> "
})

-- Settings for with preview option
local files_list_w_preview = themes.get_dropdown({
  winblend = 10,
  prompt_position = 'top',
  show_line = false,
  prompt = ">>",
  results_title = "\\ Files //",
  preview_title = false,
  layout_strategy = "flex",
  layout_config = {preview_width = 0.5}
})

local global_keys = {
  ["<C-p>"] = {"<cmd>Telescope find_files<CR>", "Open project files"},
  ["<C-f>"] = {"<cmd>Telescope live_grep<CR>", "Grep project files"},
}

local keymap = {
  E = {"<cmd>lua require\"config.telescope\".scope_browser()<CR>", "Open scope browser"},
  f = {
    name = "+Find",
    b = {"<cmd>Telescope buffers<CR>", "buffers"},
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
      s = {"<cmd>edit ~/.config/nvim/lua/settings.lua<CR>", "Edit nvim settings"},
      p = {"<cmd>edit ~/.config/nvim/lua/settings.lua<CR>", "Edit Packer plugins"}
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
wk.register(global_keys, {silent = true, noremap = true})

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
require("telescope").load_extension("frecency")

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
  local _opts = vim.deepcopy(inline_list)
  _opts.prompt_title = "~ dotfiles ~"
  _opts.cwd = "~"
  _opts.find_command = {"git", "dots", "ls-files"}
  -- _opts.layout_strategy = "flex"
  require'telescope.builtin'.find_files(_opts)
end

function _M.find_project_files()
  local _opts = vim.deepcopy(center_list_w_preview)
  local ok = pcall(require"telescope.builtin".git_files, _opts)
  if not ok then require"telescope.builtin".find_files(_opts) end
end

function _M.grep_project_files()
  local _opts = vim.deepcopy(center_list_w_preview)
  require"telescope.builtin".grep_string(_opts)
end

function _M.scope_browser()
  require('telescope.builtin').file_browser {
    layout_config = {preview_width = 0.7},
    layout_strategy = "horizontal",
    preview_title = false,
    prompt_position = 'top',
    sorting_strategy = 'ascending',
    prompt_title = ' File Browser',
    results_title = false,
    shorten_path = smart,
    show_line = false,
    width = 0.15,
    winblend = 10,
  }
end

return _M

