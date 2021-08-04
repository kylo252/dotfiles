-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.debug = true
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "tokyonight"
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.smart_cwd = true
-- keymappings
lvim.leader = "space"
lvim.keys.insert_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<S-q>"] = ":BufferWipeout<cr>"
lvim.keys.normal_mode["gL"] = ":BufferNext<cr>"
lvim.keys.normal_mode["gH"] = ":BufferPrev<cr>"
lvim.keys.normal_mode["<leader>Lc"] = ":e ~/.config/lvim/config.lua<cr>"
lvim.keys.normal_mode["<leader>Li"] =
	"<cmd>lua package.loaded['core.info']=nil; require('core.info').toggle_display()<cr>"

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

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.nvimtree.ignore = { "" }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
lvim.lang.sh.formatters = { { exe = "shfmt" } }
lvim.lang.sh.linters = { { exe = "shellcheck" } }
lvim.lang.lua.linters = { { exe = "luacheck" } }
lvim.lang.lua.formatters = { { exe = "stylua" } }
lvim.lang.typescript.formatters = { { exe = "prettier" } }
lvim.lang.typescript.linter = { { exe = "eslint" } }

lvim.builtin.rooter.active = false

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
	{ "tpope/vim-fugitive" },
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon").setup()
		end,
	},
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
--
-- local custom_mappings = require("user.core.whichkey").mappings
--
-- local og_nvim_tree_cmd = lvim.builtin.which_key.mappings["e"]
--
-- lvim.builtin.which_key.mappings = custom_mappings
-- lvim.builtin.which_key.mappings["e"] = og_nvim_tree_cmd
--
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- Additional Leader bindings for WhichKey
