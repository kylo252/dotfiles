local M = {}

function M.get_lsp_kind()
  return {
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "了",
    EnumMember = "",
    Event = "",
    Field = "ﴲ",
    File = "",
    Folder = "",
    Function = "",
    Interface = "ﰮ",
    Keyword = "",
    Method = "",
    Module = "",
    Operator = "",
    Property = " ",
    Reference = "",
    Snippet = "",
    Struct = "",
    Text = " ",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "",
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
      "<cmd>lua vim.diagnostic.open_float(0, {scope='line'}) <CR>",
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

  print("client id:", client.id)
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

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").update_capabilities(capabilities)
end

function M.setup()
  require("lsp.handlers").setup()
  require("vim.lsp.log").set_format_func(vim.inspect)
  require("lsp.null-ls").setup()

  local servers = { "clangd", "sumneko_lua", "bashls", "dockerls", "jsonls", "yamlls", "pylsp", "cmake", "null-ls" }

  for _, server in ipairs(servers) do
    require("lsp.manager").setup(server)
  end
end

return M
