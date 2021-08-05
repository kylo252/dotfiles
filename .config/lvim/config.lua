-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.debug = true
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
lvim.keys.normal_mode["<S-q>"] = ":BufferWipeout<cr>"
lvim.keys.normal_mode["gL"] = ":BufferNext<cr>"
lvim.keys.normal_mode["gH"] = ":BufferPrev<cr>"
lvim.keys.normal_mode["<space><space>"] = "<cmd>BufferNext<cr>"
lvim.keys.normal_mode["<leader>Lc"] = ":e ~/.config/lvim/config.lua<cr>"
lvim.builtin.which_key.mappings["Li"] = {
	"<cmd>lua package.loaded['core.info']=nil; require('core.info').toggle_display(vim.bo.filetype)<cr>",
	"Toggle LunarVim Info",
}

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
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon").setup()
		end,
	},
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
}

lvim.builtin.which_key.mappings["lh"] = {
	function()
		local buf = vim.api.nvim_get_current_buf()
		local ft = vim.api.nvim_buf_get_option(buf, "filetype")
		if ft == "c" or ft == "cpp" then
			vim.cmd([[ClangdSwitchSourceHeader]])
		end
	end,
	"Go To Header",
}

lvim.builtin.which_key.mappings["H"] = {
	name = "+harpoon",
	a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
	t = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle menu" },
}

require("user.core.telescope")
-- set a formatter if you want to override the default lsp one (if it exists)
local prettier_config = {
	exe = "prettier",
}

local eslint_config = {
	exe = "eslint",
}

local eslint_d_config = {
	exe = "eslint_d",
}

-- generic LSP settings
lvim.lang.sh.formatters = { { exe = "shfmt" } }
lvim.lang.sh.linters = { { exe = "shellcheck" } }

lvim.lang.python.linters = { { exe = "flake8" } }
lvim.lang.python.formatters = { { exe = "black" } }

lvim.lang.lua.formatters = { { exe = "stylua" } }

-- set an additional linter
lvim.lang.javascript.formatters = { prettier_config }
lvim.lang.javascript.linters = { eslint_d_config }

lvim.lang.typescript.formatters = { prettier_config }
lvim.lang.typescript.linters = { eslint_d_config }
lvim.lang.typescriptreact.formatters = { eslint_d_config }
lvim.lang.typescriptreact.linters = { eslint_d_config }

-- require "user.keymappings"
lvim.builtin.which_key.mappings = require("user.core.whichkey").mappings
require("user.core.telescope")
