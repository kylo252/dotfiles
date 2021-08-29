-- general

lvim.builtin.telescope.active = true
lvim.log.level = "info"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "tokyonight"
-- vim.g.rose_pine_variant = "moon"
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.smart_cwd = true
lvim.lsp.diagnostics.update_in_insert = true

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.active = true
lvim.builtin.compe.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.nvimtree.disable_window_picker = 1
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.hide_dotfiles = false
-- lvim.builtin.autopairs.active = false
lvim.lang.lua.lsp.setup.settings.Lua.telemetry = { enable = false }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}

require "user.keymappings"
-- require "scratch"

-- keymappings
lvim.builtin.which_key.mappings["gd"] = {
  [[<cmd>Gitsigns diffthis HEAD<cr>]],
  "Diff against HEAD",
}
lvim.builtin.which_key.mappings["cg"] = {
  [[<cmd>lua require('user.core.terminal').execute_command({bin = 'lazygit'})<CR>]],
  "LazyGit",
}
lvim.builtin.which_key.mappings["cd"] = {
  [[<cmd>lua require('user.core.terminal').execute_command({bin = 'lazygit', args = { "--git-dir=$HOME/.dtf.git", "--work-tree=$HOME" } })<CR>]],
  "LazyDots",
}
lvim.builtin.which_key.mappings["cl"] = {
  [[<cmd>lua require('user.core.terminal').execute_command({bin = 'lf'})<CR>]],
  "lf",
}

lvim.builtin.which_key.mappings["f"] = {
  name = "+Find",
  b = { "<cmd>Telescope buffers<CR>", "buffers" },

  d = { '<cmd>lua require("user.core.telescope").find_dotfiles()<CR>', "Find dotfiles" },
  D = { '<cmd>lua require("user.core.telescope").get_z_list()<CR>', "Zoxide" },
  e = { '<cmd>lua require("user.core.telescope").scope_browser()<CR>', "Open scope browser" },
  h = { "<cmd>Telescope help_tags<CR>", "help tags" },
  M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
  f = { "<cmd>Telescope find_files<CR>", "Find Files" },
  g = { "<cmd>Telescope grep_string<CR>", "Grep String (under-the-cursor)" },
  l = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
  L = {
    "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={vim.fn.expand(\"%:p\")} }<cr>",
    "Local live-grep",
  },
  m = { "<cmd>Telescope marks<CR>", "Marks" },
  p = { "<cmd>Telescope git_files<CR>", "Find Project Files" },
  r = { "<cmd>Telescope oldfiles<CR>", "Find Recenct Files" },
}
lvim.builtin.which_key.mappings["S"] = {
  name = "+sessions",
  d = { "<cmd>lua require('persistence').stop()<cr>", "stop saving" },
  l = { "<cmd>lua require('persistance').load()<cr>", "restore the session for the current directory" },
  r = { "<cmd>lua require('persistence').load({ last = true })<cr>)", "restore the last session" },
  s = { "<cmd>lua require('persistence').save()<cr>", "stop saving" },
}

lvim.leader = "space"
lvim.keys.insert_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<S-q>"] = "<cmd>BufferWipeout<cr>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope find_files<cr>"
lvim.keys.normal_mode["gL"] = ":BufferNext<cr>"
lvim.keys.normal_mode["gH"] = ":BufferPrev<cr>"
lvim.keys.normal_mode["<space><space>"] = "<cmd>BufferNext<cr>"
-- have to do it manually because it keeps getting overwritten in `reload_lv_config()`
lvim.keys.normal_mode["<C-h>"] = [[<cmd>lua require'tmux'.move_left()<cr>]]
lvim.keys.normal_mode["<C-j>"] = [[<cmd>lua require'tmux'.move_bottom()<cr>]]
lvim.keys.normal_mode["<C-k>"] = [[<cmd>lua require'tmux'.move_top()<cr>]]
lvim.keys.normal_mode["<C-l>"] = [[<cmd>lua require'tmux'.move_right()<cr>]]

local components = require "core.lualine.components"
-- lvim.builtin.lualine.sections.lualine_c = { "location", "filetype" } -- Add this
-- lvim.builtin.lualine.sections.lualine_b = { components.branch, "filename" }   -- or this

-- Allow pasting same thing many times
lvim.keys.visual_mode["p"] = '""p:let @"=@0<CR>'
lvim.keys.visual_block_mode["p"] = '""p:let @"=@0<CR>'
-- lvim.builtin.telescope.defaults.file_sorter = require("telescope.sorters").fuzzy_with_index_bias
lvim.builtin.telescope.extensions = {
  fzf = {
    fuzzy = true, -- false will only do exact matching
    override_generic_sorter = true, -- override the generic sorter
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
  b = { description = { "  Recent Projects    " }, command = "Telescope projects" },
  c = { description = { "  Find File          " }, command = "Telescope find_files hidden=true" },
  d = { description = { "  Plugins            " }, command = ":edit ~/.local/share/lunarvim/lvim/lua/plugins.lua" },
  e = { description = { "  Find Word          " }, command = "Telescope live_grep" },
  n = { description = { "  Load Last Session  " }, command = "<cmd>lua require('persistence').load({ last = true })" },
  s = { description = { "  Settings           " }, command = ":edit ~/.config/lvim/config.lua" },
}

-- Additional Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "rose-pine/neovim" },
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  { "jvgrootveld/telescope-zoxide" },
  {
    "aserowy/tmux.nvim",
    config = [[require('user.core.tmux')]],
  },
  {
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup()
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = [[require('user.core.sessions').setup()]],
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
lvim.lang.yaml.formatters = { { exe = "prettier" } }
---------- scratch

lvim.keys.normal_mode["<c-e>"] = ":lua package.loaded['scratch'] = nil; require('scratch').test()<cr>"

lvim.keys.normal_mode["<c-e>"] = ":lua package.loaded['scratch'] = nil; require('scratch').query_cmd('cpp')<cr>"
lvim.keys.normal_mode["<c-f>"] =
  ":lua package.loaded['lsp.manager'] = nil; require('lsp.manager').gen_ftplugin('lua')<cr>"

vim.cmd [[command! -nargs=1 GS :lua require("telescope.builtin").grep_string(require("telescope.themes").get_dropdown({ prompt_title = "Fuzzy grep string " .. "<args>", search = "<args>" }))]]

lvim.builtin.which_key.mappings["Lt"] = {
  "<cmd>lua package.loaded['core.info']=nil; package.loaded['interface.popup']=nil; require('core.info').toggle_popup(vim.bo.filetype)<cr>",
  "Toggle LunarVim Info",
}

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end

vim.cmd [[command! -nargs=1 MagicInstall :lua package.loaded['scratch']=nil; require'scratch'.query_cmd(<f-args>)]]

require "user.lsp.ft.lua".setup()
