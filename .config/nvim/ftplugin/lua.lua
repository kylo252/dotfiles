vim.cmd "setl ts=2 sw=2"

local provider_root_path = DATA_PATH .. "/lspinstall/lua"

local provider_cmd = {
  provider_root_path .. "/sumneko-lua-language-server",
  "-E",
  provider_root_path .. "/main.lua",
}

local function resolve_caps(client, bufnr)
  local caps = client.resolved_capabilities
  if caps.document_formatting then
    -- print(vim.inspect(caps))
    noop()
  end
end

local opts = {
  cmd = provider_cmd,
  autostart = true,
  on_init = resolve_caps,
  on_init = require("lsp").common_on_init,
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
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 50000,
      },
    },
  },
}
local lspconfig = require "lspconfig"

local luadev = require("lua-dev").setup { lspconfig = opts }
lspconfig.sumneko_lua.setup(luadev)
