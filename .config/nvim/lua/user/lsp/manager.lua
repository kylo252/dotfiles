local M = {}

local lsp_utils = require "user.lsp.utils"

---Resolve the configuration for a server
---@param name string
---@return table
local function resolve_config(name)
  local config = {
    on_attach = require("user.lsp").common_on_attach,
    on_init = require("user.lsp").common_on_init,
    on_exit = require("user.lsp").common_on_exit,
    capabilities = require("user.lsp").common_capabilities(),
    flags = {
      debounce_text_changes = 150,
    },
  }

  local status_ok, custom_config = pcall(require, "user.lsp.providers." .. name)
  if status_ok then
    config = vim.tbl_deep_extend("force", config, custom_config)
  end

  return config
end

---Setup a language server by providing a name
---@param server_name string name of the language server
function M.setup(server_name)
  vim.validate { name = { server_name, "string" } }

  if lsp_utils.is_client_active(server_name) then
    return
  end

  local config = resolve_config(server_name)
  require("lspconfig")[server_name].setup(config)
end

return M
