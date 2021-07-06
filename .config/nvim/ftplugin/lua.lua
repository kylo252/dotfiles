vim.cmd("set sw=2")
vim.cmd("set ts=2")

local sumneko_root_path = DATA_PATH .. "/lspinstall/lua"
sumneko_cmd = { sumneko_root_path .. "/sumneko-lua-language-server", "-E", sumneko_root_path .. "/main.lua" }

require("lspconfig").sumneko_lua.setup({
	cmd = sumneko_cmd,
	autostart = true,
	on_attach = require("lsp").common_on_attach,
	settings = {
		Lua = {
			telemetry = { enable = false },
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "DATA_PATH" },
				disable = { "undefined-global" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 50000,
			},
		},
	},
})

if O.lang.lua.autoformat then
	require("utils").define_augroups({
		_lua_autoformat = {
			{
				"BufWritePre",
				"*.lua",
				"lua vim.lsp.buf.formatting_sync(nil, 1000)",
			},
		},
	})
end

require("lsp.efm-general-ls").generic_setup({"lua"})