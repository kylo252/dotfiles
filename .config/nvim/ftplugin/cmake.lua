local provider = "cmake-language-server"

if vim.fn.executable(provider) ~= 1 then
  provider = DATA_PATH .. "/lspinstall/cmake/venv/bin/" .. provider
end

local opts = {
  cmd = { provider, "--stdio" },
  on_init = require("lsp").common_on_init,
  on_attach = require("lsp").common_on_attach,
  filetypes = { "cmake" },
}

require("lspconfig").cmake.setup(opts)
