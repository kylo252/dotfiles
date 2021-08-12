-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
lvim.log.level = "error"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "tokyonight"
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.smart_cwd = true
lvim.builtin.rooter.active = false

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.nvimtree.ignore = { "" }
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.hide_dotfiles = false
lvim.builtin.rooter.active = false

-- keymappings
lvim.leader = "space"
lvim.keys.insert_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<S-q>"] = "<cmd>BufferWipeout<cr>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope find_files<cr>"
lvim.keys.normal_mode["gL"] = ":BufferNext<cr>"
lvim.keys.normal_mode["gH"] = ":BufferPrev<cr>"
lvim.keys.normal_mode["<space><space>"] = "<cmd>BufferNext<cr>"
lvim.keys.normal_mode["<leader>Lc"] = ":e ~/.config/lvim/config.lua<cr>"
lvim.builtin.which_key.mappings["Li"] = {
  "<cmd>lua package.loaded['core.info']=nil; require('core.info').toggle_popup(vim.bo.filetype)<cr>",
  "Toggle LunarVim Info",
}

lvim.builtin.which_key.mappings["dl"] = {
  "<cmd>lua require('user.core.telescope').find_lunarvim_files()<cr>",
  "Find LunarVim file",
}
lvim.builtin.which_key.mappings["de"] = {
  "<cmd>lua require('user.core.telescope').find_dotfiles()<cr>",
  "Find dotfiles",
}

lvim.builtin.which_key.mappings["j"] = { "<cmd>BufferPick<cr>", "magic buffer-picking mode" }

-- Allow pasting same thing many times
lvim.keys.visual_mode["p"] = '""p:let @"=@0<CR>'
lvim.keys.visual_block_mode["p"] = '""p:let @"=@0<CR>'

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

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").on_attach()
    end,
    event = "InsertEnter",
  },
  {
    "folke/trouble.nvim",
    config = [[require('user.core.trouble')]],
    -- event = "BufWinEnter"
  },
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  { "nanotee/zoxide.vim", cmd = "Z" },
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup {
        copy_sync = {
          enable = true,
          redirect_to_clipboard = true,
          sync_deletes = true,
        },
        navigation = {
          cycle_navigation = true,
          enable_default_keybindings = true,
          persist_zoom = false,
        },
        resize = {
          enable_default_keybindings = true,
        },
      }
    end,
  },
}

lvim.builtin.which_key.mappings["lh"] = {
  function()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "c" or ft == "cpp" then
      vim.cmd [[ClangdSwitchSourceHeader]]
    end
  end,
  "Go To Header",
}

lvim.builtin.which_key.mappings["H"] = {
  name = "+harpoon",
  a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
  t = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle menu" },
}

require "user.core.telescope"
-- set a formatter if you want to override the default lsp one (if it exists)

-- generic LSP settings
lvim.lang.sh.linters = { { exe = "shellcheck" } }
lvim.lang.sh.formatters = { { exe = "shfmt" } }

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

local user_mappings = require("user.core.whichkey").mappings
lvim.builtin.which_key.mappings = vim.tbl_deep_extend("force", lvim.builtin.which_key.mappings, user_mappings)

lvim.builtin.which_key.mappings["fE"] = {
  "<cmd>lua require('user.core.telescope').scope_browser()<cr>",
  "open scope browser",
}
require "user.core.telescope"
vim.cmd [[cmap <C-R> <Plug>(TelescopeFuzzyCommandSearch)]]

lvim.builtin.which_key.mappings["T"] = {
  -- "<cmd>lua print(vim.inspect(require('lsp').get_ls_capabilities(1)))<cr>",
  -- "<cmd>lua require('telescope.builtin').grep_string({ layout_strategy = 'center', only_sort_text = true, search = 'win' })<cr>>",

  ":lua package.loaded['core.telescope'] = nil; require('core.telescope').fuzzy_grep_string()<cr>",
  "Test Telescope grep",
}

vim.cmd [[command! -nargs=* GS :lua require('user.core.telescope').fuzzy_grep_string(<f-args>) ]]

-- vim.cmd(
-- 	[[command! -nargs=1 GS :lua require("telescope.builtin").grep_string(require("telescope.themes").get_dropdown({ prompt_title = "Fuzzy grep string " .. "<args>", search = "<args>" }))]]
-- )

-- testing if this actually works (it doesn't...)
lvim.keys.visual_mode["<leader>fg"] = "<cmd>Telescope grep_string<cr>"

-- hello

-- hel

-- lo
