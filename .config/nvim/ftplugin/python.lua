-- npm i -g pyright

local provider = "pyright-langserver"

if vim.fn.executable(provider) ~= 1 then
  provider = DATA_PATH .. "/lspinstall/python/node_modules/.bin/" .. provider
end

local opts = {
  cmd = { provider, "--stdio" },
  on_attach = require("lsp").common_on_attach,
}

require("lspconfig").pyright.setup(opts)

-- require("lsp.efm-general-ls").generic_setup { "python" }
