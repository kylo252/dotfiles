-- npm i -g pyright
require("lspconfig").pyright.setup {
  cmd = {
    DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
    "--stdio",
  },
  on_attach = require("lsp").common_on_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = O.lang.python.diagnostics.virtual_text,
      signs = O.lang.python.diagnostics.signs,
      underline = O.lang.python.diagnostics.underline,
      update_in_insert = true,
    }),
  },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = O.lang.python.analysis.type_checking,
        autoSearchPaths = O.lang.python.analysis.auto_search_paths,
        useLibraryCodeForTypes = O.lang.python.analysis.use_library_code_types,
      },
    },
  },
}

if O.plugin.debug.active and O.plugin.dap_install.active then
  local dap_install = require("dap-install")
  dap_install.config("python_dbg", {})
end

require("lsp.efm-general-ls").generic_setup({"python"})
