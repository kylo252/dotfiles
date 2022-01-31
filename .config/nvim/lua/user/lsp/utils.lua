local M = {}

function M.is_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true, client
    end
  end
  return false
end

function M.get_active_client_by_ft(filetype)
  local matches = {}
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    local supported_filetypes = client.config.filetypes or {}
    if client.name ~= "null-ls" and vim.tbl_contains(supported_filetypes, filetype) then
      table.insert(matches, client)
    end
  end
  return matches
end

function M.conditional_document_highlight(id)
  local client_ok, method_supported = pcall(function()
    return vim.lsp.get_client_by_id(id).resolved_capabilities.document_highlight
  end)
  if not client_ok or not method_supported then
    return
  end
  vim.lsp.buf.document_highlight()
end

return M
