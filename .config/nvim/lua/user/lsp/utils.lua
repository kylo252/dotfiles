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

function M.format(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.buf_get_clients(bufnr)

  if opts.filter then
    clients = opts.filter(clients)
  elseif opts.id then
    clients = vim.tbl_filter(
      function(client) return client.id == opts.id end,
      clients
    )
  elseif opts.name then
    clients = vim.tbl_filter(
      function(client) return client.name == opts.name end,
      clients
    )
  end

  clients = vim.tbl_filter(
    function(client) return client.supports_method("textDocument/formatting") end,
    clients
  )

  if #clients == 0 then
    vim.notify("[LSP] Format request failed, no matching language servers.")
  end

  local timeout_ms =  opts.timeout_ms or 1000
  for _, client in pairs(clients) do
      local params = vim.lsp.util.make_formatting_params(opts.formatting_options)
      local result, err = client.request_sync("textDocument/formatting", params, timeout_ms, bufnr)
      if result and result.result then
        vim.lsp.util.apply_text_edits(result.result, bufnr, client.offset_encoding)
      elseif err then
        vim.notify(string.format("[LSP][%s] %s", client.name, err), vim.log.levels.WARN)
      end
  end
end

function M.get_client_capabilities(client_id)
  local client
  if not client_id then
    local buf_clients = vim.lsp.buf_get_clients()
    for _, buf_client in pairs(buf_clients) do
      if buf_client.name ~= "null-ls" then
        client = buf_client
        break
      end
    end
  else
    client = vim.lsp.get_client_by_id(tonumber(client_id))
  end

  local lsp_caps = client.resolved_capabilities

  print("client id:", client.id)
  print("client name:", client.name)
  print("resolved_capabilities:", vim.inspect(lsp_caps))

  return lsp_caps
end

return M
