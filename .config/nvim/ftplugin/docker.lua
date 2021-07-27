-- npm install -g dockerfile-language-server-nodejs

local provider = "docker-langserver"

if vim.fn.executable(provider) ~= 1 then
  provider = DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/" .. provider
end

local opts = {
  cmd = { provider, "--stdio" },
  on_attach = require("lsp").common_on_attach,
  root_dir = vim.loop.cwd,
}

require("lspconfig").dockerls.setup(opts)
