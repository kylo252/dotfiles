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

--luacheck: no unused args
---@diagnostic disable-next-line: unused-local
function M.common_on_init(client, bufnr) end

function M.common_on_exit(_, _)
  require("user.autocmds").clear_augroup "lsp_document_highlight"
end

function M.common_on_attach(client, bufnr)
  require("user.lsp.utils").setup_document_highlight(client, bufnr)
  setup_lsp_keybindings(bufnr)
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return require("cmp_nvim_lsp").update_capabilities(capabilities)
end

function M.get_common_opts()
  return {
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    on_exit = M.common_on_exit,
    capabilities = M.common_capabilities(),
  }
end

local function bootstrap_nlsp(opts)
  opts = opts or {}
  local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
  if lsp_settings_status_ok then
    lsp_settings.setup(opts)
  end
end

function M.setup()
  require("user.lsp.handlers").setup()
  require("vim.lsp.log").set_format_func(vim.inspect)
  bootstrap_nlsp {
    config_home = vim.fn.stdpath "config" .. "/lsp-settings",
    append_default_schemas = true,
    local_settings_dir = ".lsp",
    local_settings_root_markers = { ".git" },
    loader = "json",
  }
  require("user.lsp.null-ls").setup()

  local servers = { "clangd", "sumneko_lua", "bashls", "dockerls", "jsonls", "yamlls", "pyright", "cmake" }

  for _, server in ipairs(servers) do
    require("user.lsp.manager").setup(server)
  end
  vim.api.nvim_create_augroup("lsp_document_highlight", {})
end

return M
