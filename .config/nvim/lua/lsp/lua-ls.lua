-- create a symlink If built manually
-- `ln -s ./bin/Linux/lua-language-server .`
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

local sumneko_cmd

if vim.fn.executable("lua-language-server") == 1 then
  sumneko_cmd = {"lua-language-server"}
else
  local sumneko_root_path = DATA_PATH.."/lspinstall/lua"
  sumneko_cmd = {sumneko_root_path.."/bin/Linux/lua-language-server", "-E", sumneko_root_path.."/main.lua" }
end

require'lspconfig'.sumneko_lua.setup {
    cmd = sumneko_cmd,
	autostart = true,
    on_attach = require'lsp'.common_on_attach,
    settings = {
        Lua = {
			telemetry = {
			    enable = false
			},
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim', 'DATA_PATH', 'O'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
                maxPreload = 10000
            }
        }
    }
}

