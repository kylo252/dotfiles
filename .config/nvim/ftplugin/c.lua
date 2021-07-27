local clangd_flags = {
  "--background-index",
  "--header-insertion=never",
  "--cross-file-rename",
  "--clang-tidy",
  "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*",
}

local provider = "clangd"

if vim.fn.executable(provider) ~= 1 then
  provider = DATA_PATH .. "/lspinstall/cpp/clangd/bin/" .. provider
end

local opts = {
  cmd = { provider, unpack(clangd_flags) },
  on_attach = require("lsp").common_on_attach,
}

require("lspconfig").clangd.setup(opts)
