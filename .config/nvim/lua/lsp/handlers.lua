local M = {}

function M.setup()
  local signs = {
    { name = "LspDiagnosticsSignError", text = "" },
    { name = "LspDiagnosticsSignWarning", text = "" },
    { name = "LspDiagnosticsSignHint", text = "" },
    { name = "LspDiagnosticsSignInformation", text = "" },
  }

  local sign_names = {
    "DiagnosticSignError",
    "DiagnosticSignWarn",
    "DiagnosticSignInfo",
    "DiagnosticSignHint",
  }

  for i, sign in ipairs(signs) do
    vim.fn.sign_define(sign_names[i], { texthl = sign_names[i], text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false,
    signs = signs,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
  }

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })
end

return M
