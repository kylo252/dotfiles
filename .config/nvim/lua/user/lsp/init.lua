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
  local visual_keys = { ["<leader>lf"] = { "<esc><cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format" } }

  wk.register(visual_keys, { mode = "x", buffer = bufnr })

  local keys = {
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
    ["gI"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "show signature help" },
    ["gl"] = {
      "<cmd>lua vim.diagnostic.open_float(0, {scope='line'}) <CR>",
      "Show line diagnostics",
    },
  }

  wk.register(keys, { mode = "n", buffer = bufnr })
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

--luacheck: no unused args
function M.common_on_init(client, bufnr) end

--luacheck: no unused args
function M.common_on_attach(client, bufnr)
  require("user.autocmds").enable_lsp_document_highlight(client.id)
  setup_lsp_keybindings(bufnr)
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").update_capabilities(capabilities)
end

function M.setup()
  require("user.lsp.handlers").setup()
  require("vim.lsp.log").set_format_func(vim.inspect)
  require("user.lsp.null-ls").setup()

  local servers = { "clangd", "sumneko_lua", "bashls", "dockerls", "jsonls", "yamlls", "pylsp", "cmake" }

  for _, server in ipairs(servers) do
    require("user.lsp.manager").setup(server)
  end
end

return M
