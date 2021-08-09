-- npm install -g vscode-json-languageserver
local provider = "vscode-json-languageserver"

if vim.fn.executable(provider) ~= 1 then
  provider = "node"
    .. DATA_PATH
    .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js"
end

local opts = {
  cmd = { provider, "--stdio" },
  on_init = require("lsp").common_on_init,
  on_attach = require("lsp").common_on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
      end,
    },
  },
}

require("lspconfig").jsonls.setup(opts)

-- require("lsp.efm-general-ls").generic_setup { "json" }
