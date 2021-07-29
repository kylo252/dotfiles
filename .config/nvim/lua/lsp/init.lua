local lsp_config = {}

local u = require "utils"

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 了 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  "   (Constant)",
  "   (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)",
}

local function setup_lsp_handlers(test)
  --[[ vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = true,
    signs = true,
    underline = true,
  }) ]]

  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
    local config = { -- your config
      underline = true,
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    }
    local uri = params.uri
    local bufnr = vim.uri_to_bufnr(uri)

    if not bufnr then
      return
    end

    local diagnostics = params.diagnostics

    for i, v in ipairs(diagnostics) do
      diagnostics[i].message = string.format("%s: %s", v.source, v.message)
    end

    vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    -- border = popup_border,
    border = single,
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    -- border = popup_border,
    border = single,
  })
end

local function setup_lsp_keybindings()
  u.add_buf_keymap("n", { noremap = true, silent = true }, {
    { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
    { "gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
    { "gp", "<cmd>lua require'lsp'.PeekDefinition()<CR>" },
    { "gl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })<CR>" },
    { "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>" },
    { "]d", "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>" },
    { "K", "<cmd>lua vim.lsp.buf.hover()<CR>" },
    { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
  })
end

local function documentHighlight(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

function lsp_config.common_on_attach(client, bufnr)
  setup_lsp_handlers()
  documentHighlight(client)
  setup_lsp_keybindings()
end

function lsp_config.get_ls_capabilities(client_id)
  local client
  if not client_id then
    local buf_clients = vim.lsp.buf_get_clients()
    local first_client_id = vim.tbl_keys(buf_clients)[1]
    client = vim.lsp.get_client_by_id(tonumber(first_client_id))
  else
    client = vim.lsp.get_client_by_id(tonumber(client_id))
  end

  local lsp_caps = client.resolved_capabilities

  print("client id: ", client.id)
  print("client name:", client.name)
  -- print(vim.inspect(client))
  print("resolved_capabilities:", vim.inspect(lsp_caps))

  return lsp_caps
end

return lsp_config
