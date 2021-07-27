-- npm i -g bash-language-server

vim.cmd "set sw=2 ts=2"
local ft = { "sh", "bash", "zsh" }

local provider = "bash-language-server"

if vim.fn.executable(provider) ~= 1 then
  provider = DATA_PATH .. "/lspinstall/bash/node_modules/.bin/" .. provider
end

local opts = {
  cmd = { provider, "start" },
  on_attach = require("lsp").common_on_attach,
  root_dir = vim.loop.cwd,
  filetypes = ft,
}

require("lspconfig").bashls.setup(opts)

-- require("lsp.efm-general-ls").generic_setup(ft)
