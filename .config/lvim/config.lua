-- general
lvim.log.level = "error"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "tokyonight"
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.smart_cwd = true
lvim.lsp.diagnostics.update_in_insert = true
lvim.builtin.rooter.active = false

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.nvimtree.ignore = { "" }
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.hide_dotfiles = false
lvim.builtin.rooter.active = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}

-- require "user.core.telescope"
require "user.keymappings"
require "scratch"

-- keymappings
local user_mappings = require("user.core.whichkey").mappings
lvim.builtin.which_key.mappings = vim.tbl_deep_extend("force", lvim.builtin.which_key.mappings, user_mappings)

lvim.leader = "space"
lvim.keys.insert_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<S-q>"] = "<cmd>BufferWipeout<cr>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope find_files<cr>"
lvim.keys.normal_mode["gL"] = ":BufferNext<cr>"
lvim.keys.normal_mode["gH"] = ":BufferPrev<cr>"
lvim.keys.normal_mode["<space><space>"] = "<cmd>BufferNext<cr>"
lvim.keys.normal_mode["<leader>Lc"] = ":e ~/.config/lvim/config.lua<cr>"

-- fix telescope functions' scope
lvim.builtin.which_key.mappings["fn"] = {
  "<cmd>lua require('user.core.telescope').find_lunarvim_files()<cr>",
  "Find LunarVim file",
}
lvim.builtin.which_key.mappings["fd"] = {
  "<cmd>lua require('user.core.telescope').find_dotfiles()<cr>",
  "Find dotfiles",
}
lvim.builtin.which_key.mappings["fE"] = {
  "<cmd>lua require('user.core.telescope').scope_browser()<cr>",
  "open scope browser",
}

-- Allow pasting same thing many times
lvim.keys.visual_mode["p"] = '""p:let @"=@0<CR>'
lvim.keys.visual_block_mode["p"] = '""p:let @"=@0<CR>'

lvim.builtin.telescope.extensions = {
  fzf = {
    fuzzy = true, -- false will only do exact matching
    override_generic_sorter = false, -- override the generic sorter
    override_file_sorter = true, -- override the file sorter
    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    -- the default case_mode is "smart_case"
  },
}
lvim.builtin.telescope.on_config_done = function()
  require("telescope").load_extension "fzf"
end

vim.api.nvim_set_keymap("i", "<c-y>", "compe#confirm({ 'keys': '<c-y>', 'select': v:true })", { expr = true })

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.dashboard.custom_section = {
  a = { description = { "  Recently Used Files" }, command = "Telescope oldfiles" },
  b = { description = { "  Find File          " }, command = "Telescope find_files" },
  c = { description = { "  Plugins            " }, command = ":edit ~/.config/nvim/lua/plugins.lua" },
  s = { description = { "  Settings           " }, command = ":edit ~/.config/lvim/config.lua" },
  d = { description = { "  Find Word          " }, command = "Telescope live_grep" },
  n = { description = { "  Load Last Session  " }, command = "SessionLoad" },
  m = { description = { "  Marks              " }, command = "Telescope marks" },
}

-- Additional Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  {
    "folke/trouble.nvim",
    config = [[require('user.core.trouble')]],
    -- event = "BufWinEnter"
  },
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  { "nanotee/zoxide.vim", cmd = "Z" },
  {
    "aserowy/tmux.nvim",
    config = [[require('user.core.tmux')]],
  },
}

-- generic LSP settings
lvim.lang.sh.linters = { { exe = "shellcheck" } }
lvim.lang.sh.formatters = { { exe = "shfmt", args = { "-i", "2", "-ci" } } }

lvim.lang.python.linters = { { exe = "flake8" } }
lvim.lang.python.formatters = { { exe = "black" } }

lvim.lang.lua.formatters = { { exe = "stylua" } }
lvim.lang.lua.linters = { { exe = "luacheck" } }

-- set an additional linter
lvim.lang.javascript.formatters = { { exe = "prettier" } }
lvim.lang.javascript.linters = { { exe = "eslint_d" } }

lvim.lang.typescript.formatters = { { exe = "prettier" }, { exe = "prettierd" } }
lvim.lang.typescript.linters = { { exe = "eslint_d" } }
lvim.lang.typescriptreact.formatters = { { exe = "prettier" } }
lvim.lang.typescriptreact.linters = { { exe = "eslint_d" } }

---------- scratch

lvim.keys.normal_mode["<c-f>"] = ":lua package.loaded['scratch'] = nil; require('scratch').test()<cr>"

lvim.keys.normal_mode["<c-e>"] = ":lua package.loaded['scratch'] = nil; require('scratch').test2()<cr>"

-- vim.cmd(
-- 	[[command! -nargs=1 GS :lua require("telescope.builtin").grep_string(require("telescope.themes").get_dropdown({ prompt_title = "Fuzzy grep string " .. "<args>", search = "<args>" }))]]
-- )

lvim.builtin.which_key.mappings["Li"] = {
  "<cmd>lua package.loaded['core.info']=nil; require('core.info').toggle_popup(vim.bo.filetype)<cr>",
  "Toggle LunarVim Info",
}
