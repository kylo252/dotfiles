-- npm install -g yaml-language-server
local provider = "yaml-language-server"

if vim.fn.executable(provider) ~= 1 then
  provider = DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/" .. provider
end

local opts = {
  cmd = { provider, "--stdio" },
  on_init = require("lsp").common_on_init,
  on_attach = require("lsp").common_on_attach,
  settings = {
    yaml = {
      scheme = {
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.yml",
      },
    },
  },
}

require("lspconfig").yamlls.setup(opts)

vim.cmd "setl ts=2 sw=2 ts=2 ai et"
