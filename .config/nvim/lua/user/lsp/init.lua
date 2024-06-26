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
  local buffer_mappings = {
    normal_mode = {
      ["K"] = { vim.lsp.buf.hover, "Show hover" },
      ["gd"] = { vim.lsp.buf.definition, "Goto definition" },
      ["[d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
      ["]d"] = { vim.diagnostic.goto_prev, "Prev diagnostic" },
      ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
      ["gr"] = { vim.lsp.buf.references, "Goto references" },
      ["gI"] = { vim.lsp.buf.implementation, "Goto implementation" },
      ["gs"] = { vim.lsp.buf.signature_help, "Show signature help" },
      ["gl"] = { vim.diagnostic.open_float, "Show line diagnostics" },
      ["<leader>la"] = { vim.lsp.buf.code_action, "Code Action" },
      ["<leader>lf"] = { vim.lsp.buf.format, "Format" },
      ["<leader>lr"] = { vim.lsp.buf.rename, "Rename" },
      ["<leader>lq"] = { vim.diagnostic.setloclist, "Jumplist Diagnostics" },
    },
    insert_mode = {},
    visual_mode = {},
  }

  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
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

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- use gq for formatting
  buf_set_option("formatexpr", "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok and cmp_nvim_lsp then
    return cmp_nvim_lsp.default_capabilities()
  end
  return vim.lsp.protocol.make_client_capabilities()
end

function M.get_common_opts()
  return {
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    on_exit = M.common_on_exit,
    capabilities = M.common_capabilities(),
  }
end

function M.setup()
  require("user.lsp.handlers").setup()
  require("vim.lsp.log").set_format_func(vim.inspect)

  require("user.lsp.null-ls").setup()

  -- needs to be called before setting up jsonls
  pcall(function()
    require("nlspsettings").setup {
      config_home = vim.fn.stdpath "config" .. "/lsp-settings",
      append_default_schemas = true,
      local_settings_dir = ".lsp",
      local_settings_root_markers = { ".git", ".lsp" },
      loader = "json",
      ignored_servers = {},
      open_strictly = false,
    }
  end)

  local servers = {
    "clangd",
    "lua_ls",
    "bashls",
    "dockerls",
    "jsonls",
    "yamlls",
    "pyright",
    "ruff_lsp",
    "cmake",
  }

  for _, server in ipairs(servers) do
    require("user.lsp.manager").setup(server)
  end
end

return M
