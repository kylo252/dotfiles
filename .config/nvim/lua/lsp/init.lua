local M = {}

function M.get_lsp_kind()
  -- symbols for autocomplete
  return {
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
end

vim.lsp.protocol.CompletionItemKind = M.get_lsp_kind()
    
local function setup_lsp_keybindings(bufnr)
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    return
  end
  local visual_keys = { ["<leader>lf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format" } }

  wk.register(visual_keys, { mode = "x", buffer = bufnr })

  local keys = {
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
    ["gI"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "show signature help" },
    ["gp"] = { "<cmd>lua require'lsp.peek'.Peek('definition')<CR>", "Peek definition" },
    ["gl"] = {
      "<cmd>lua vim.diagnostic.show_line_diagnostics({source = 'always'}) <CR>",
      "Show line diagnostics",
    },
  }

  wk.register(keys, { mode = "n", buffer = bufnr })
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
  print("resolved_capabilities:", vim.inspect(lsp_caps))

  return lsp_caps
end

local function setup_document_highlight(client)
  -- TODO: move this so that it done only once
  -- https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
  vim.cmd [[ hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646 ]]
  vim.cmd [[ hi LspReferenceText cterm=bold ctermbg=red guibg=#464646 ]]
  vim.cmd [[ hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646 ]]
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

--luacheck: no unused args
function M.common_on_init(client, bufnr)
  setup_document_highlight(client)
end

--luacheck: no unused args
function M.common_on_attach(client, bufnr)
  setup_lsp_keybindings(bufnr)
end

function M.setup()
  local nvim_lsp = require "lspconfig"
  local servers = { "clangd", "sumneko_lua", "bashls", "dockerls", "jsonls", "yamlls", "pyright", "cmake" }
  require("lsp.handlers").setup()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local default_config = {
    autostart = true,
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  for _, server in ipairs(servers) do
    local status_ok, config = pcall(require, "lsp/providers/" .. server)
    local new_config
    if status_ok then
      new_config = vim.tbl_deep_extend("keep", vim.empty_dict(), config)
      new_config = vim.tbl_deep_extend("keep", new_config, default_config)
      nvim_lsp[server].setup(new_config)
    else
      nvim_lsp[server].setup(default_config)
    end
  end

  require("lsp.null-ls").setup()
end
return M
