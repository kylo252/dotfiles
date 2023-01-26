local M = {}

function M.setup()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false,
    signs = signs,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      suffix = nil,
      format = nil,
    },
  }

  vim.diagnostic.config(config)
  local float_opts = {
    focusable = false,
    style = "minimal",
    border = "rounded",
  }
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_opts)
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

  -- Get a reference to the original signs handler
  local orig_signs_handler = vim.diagnostic.handlers.signs
  vim.diagnostic.handlers.signs = {
    show = function(ns, bufnr, diagnostics, opts)
      -- diagnostics from the whole buffer, not just those passed to the handler
      -- local diagnostics = vim.diagnostic.get(bufnr) -- disabled because slow!

      -- perf: avoid showing too many signs
      if #diagnostics > 30 then
        return
      end

      -- Find the "worst" diagnostic per line
      local max_severity_per_line = {}
      for _, d in pairs(diagnostics) do
        local m = max_severity_per_line[d.lnum]
        if not m or d.severity < m.severity then
          max_severity_per_line[d.lnum] = d
        end
      end

      -- Pass the filtered diagnostics (with our custom namespace) to
      -- the original handler
      local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
      orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
    end,
    hide = function(ns, bufnr)
      orig_signs_handler.hide(ns, bufnr)
    end,
  }
end

return M
