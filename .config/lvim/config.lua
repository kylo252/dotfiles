-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.debug = false
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "tokyonight"
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
-- keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<S-l>"] = ""
lvim.keys.normal_mode["<S-h>"] = ""
lvim.keys.normal_mode["gL"] = ":BufferNext<cr>"
lvim.keys.normal_mode["gH"] = ":BufferPrev<cr>"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.dashboard.custom_section = {
	a = { description = { "  Recently Used Files" }, command = "Telescope oldfiles" },
	b = { description = { "  Find File          " }, command = "Telescope find_files" },
	c = { description = { "  Plugins            " }, command = ":edit ~/.config/nvim/lua/plugins.lua" },
	s = { description = { "  Settings           " }, command = ":edit ~/.config/nvim/lua/settings.lua" },
	d = { description = { "  Find Word          " }, command = "Telescope live_grep" },
	n = { description = { "  Load Last Session  " }, command = "SessionLoad" },
	m = { description = { "  Marks              " }, command = "Telescope marks" },
}

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

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

-- require "user.keymappings"
-- require "user.core.telescope"
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
