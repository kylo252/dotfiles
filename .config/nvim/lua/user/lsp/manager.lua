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

function M.manual_setup(name)
  local opts = {
    reuse_client = function(client, conf)
      -- return client.config.root_dir == conf.root_dir and client.name == conf.name
      local buf_path = vim.fn.expand "%:p:h"
      local root_dir =
        vim.fs.dirname(vim.fs.find({ ".git" }, { path = buf_path, upward = true })[1])
      -- vim.notify("got: " .. root_dir)
      if root_dir and client.name == conf.name then
        require("user.lsp.ws").add_workspace_folder(root_dir, { id = client.id })
        return true
      end
    end,
  }
  local root_dir = vim.fs.dirname(vim.fs.find({ ".luarc.json", ".git" }, { upward = true })[1])

  local ws = { {
    name = root_dir,
    uri = vim.uri_from_fname(root_dir),
  } }
  local config = resolve_config(name)

  local ls_found, lspconf = pcall(require, "lspconfig.server_configurations." .. name)
  if ls_found then
    config = vim.tbl_deep_extend("force", lspconf.default_config, config)
    if type(config.root_dir) == "function" then
      config.root_dir = config.root_dir(vim.loop.cwd())
    end
    config.name = config.name or name
  end
  config.root_dir = nil
  config.workspace_folders = ws
  vim.lsp.start(config, opts)
end

return M
