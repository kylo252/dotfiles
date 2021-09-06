local M = {}

function M.set_sigature()
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    -- border = popup_border,
    border = single,
  })
end

function M.set_hover()
  vim.lsp.with(vim.lsp.handlers.hover, {
    -- border = popup_border,
    border = single,
  })
end

function M.set_diagnostics()
end

return M
