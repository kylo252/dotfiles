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

local function resolve_bufnr(bufnr)
  vim.validate { bufnr = { bufnr, "n", true } }
  if bufnr == nil or bufnr == 0 then
    return vim.api.nvim_get_current_buf()
  end
  return bufnr
end

---@private
---Resolve a workspace for a client
---
---@param markers string[] list of search patterns
---@param bufnr number
---@return table|nil list of `{ uri:string, name: string }`
local function resolve_workspace(markers, bufnr)
  if not markers then
    return
  end
  bufnr = resolve_bufnr(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local buf_path = vim.fs.dirname(bufname)
  local anchor =
    vim.fs.find(markers, { path = buf_path, stop = vim.loop.os_homedir(), upward = true })[1]
  if not anchor then
    return
  end
  local root_dir = vim.fs.dirname(anchor)
  local ws = {
    name = root_dir,
    uri = vim.uri_from_fname(root_dir),
  }
  return ws
end

---@private
---Returns true if a workspace marker for a given client is found
---
---@param client table see |vim.lsp.client|
---@param config table
---@param bufnr number
---@return boolean|nil
local function should_reuse_client(client, config, bufnr)
  if client.name == config.name then
    return
  end
  bufnr = resolve_bufnr(bufnr)
  local ws = resolve_workspace(config.workspace_markers, bufnr)
  if not ws then
    return
  end
  for _, folder in ipairs(client.workspace_folders) do
    if ws.uri == folder.uri then
      return true
    end
  end
  return vim.lsp.add_workspace_folder(ws, { id = client.id })
end

---Setup a language server by providing a name
---@param server_name string name of the language server
---@param overrrides table? when available it will take predence over any default configurations
function M.setup_manual(server_name, overrrides)
  vim.validate { name = { server_name, "string" } }
  overrrides = overrrides or {}
  local success, conf = pcall(require, "lspconfig.server_configurations." .. server_name)
  if not success then
    vim.notify(
      string.format("[lspconfig] This setup API is not supported for (%s) ..", server_name),
      vim.log.levels.WARN
    )
    return
  end
  local config = vim.tbl_deep_extend("force", conf.default_config, overrrides)

  -- this is missing by default for some reason..
  config.name = config.name or server_name

  -- only use git repos by default
  config.workspace_markers = config.workspace_markers or { ".git" }

  local bufnr = vim.api.nvim_get_current_buf()
  config.workspace_folders = config.workspace_folders
    or { resolve_workspace(config.workspace_markers, bufnr) }
  local opts = {
    reuse_client = should_reuse_client,
  }
  vim.lsp.start(config, opts)
end

return M
