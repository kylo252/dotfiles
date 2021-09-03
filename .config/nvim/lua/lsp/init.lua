local M = {}

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

local function setup_lsp_keybindings(bufnr)
  local wk = require "which-key"
  local keys = {
    ["K"] = { "<cmd>lua vim.lsp.buf.hover({focusable = false})<CR>", "Show hover" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
    ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation" },
    ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help({focusable = false})<CR>", "show signature help" },
    ["gp"] = { "<cmd>lua require'lsp.peek'.Peek('definition')<CR>", "Peek definition" },
    ["gl"] = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Show line diagnostics" },
  }
  wk.register(keys, { mode = "n", buffer = bufnr })
  local visual_keys = { f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" } }

  wk.register(visual_keys, { mode = "v", buffer = bufnr })
end

function M.get_ls_capabilities(client_id)
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

local function setup_document_highlight(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
  end
end

function M.common_on_init(client, bufnr)
  local handlers = require "lsp.handlers"
  vim.lsp.handlers["textDocument/publishDiagnostics"] = handlers.set_diagnostics
  vim.lsp.handlers["textDocument/hover"] = handlers.set_hover
  vim.lsp.handlers["textDocument/signatureHelp"] = handlers.set_sigature
  -- TODO: move this so that it done only once
  -- https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
  vim.cmd [[ hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646 ]]
  vim.cmd [[ hi LspReferenceText cterm=bold ctermbg=red guibg=#464646 ]]
  vim.cmd [[ hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646 ]]
end

function M.common_on_attach(client, bufnr)
  setup_document_highlight(client)
  setup_lsp_keybindings(bufnr)
end

function M.setup()
  local nvim_lsp = require "lspconfig"
  local servers = { "clangd", "sumneko_lua", "bashls", "dockerls", "jsonls", "yamlls", "pyright" }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local opts = {
    autostart = true,
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    apabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  for _, server in ipairs(servers) do
    local status_ok, provider_opts = pcall(require, "lsp/providers/" .. server)
    if status_ok then
      local new_config = vim.tbl_deep_extend("keep", {}, opts, provider_opts)
      nvim_lsp[server].setup(new_config)
    else
      nvim_lsp[server].setup(opts)
    end
  end

  require("lsp.efm-general-ls").generic_setup { "lua", "sh", "zsh", "bash", "yaml" }
end
return M
