-- npm i -g bash-language-server
vim.cmd "set sw=2 ts=2"
local ft = { "sh", "bash" }

require("lspconfig").bashls.setup {
  cmd = {
    DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server",
    "start",
  },
  on_attach = require("lsp").common_on_attach,
  filetypes = ft,
}

require("lsp.efm-general-ls").generic_setup(ft)
