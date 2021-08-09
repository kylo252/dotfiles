local utils = {}

-- autoformat
function utils.toggle_autoformat()
  if lvim.format_on_save then
    require("core.autocmds").define_augroups {
      autoformat = {
        {
          "BufWritePre",
          "*",
          ":silent lua vim.lsp.buf.formatting_sync()",
        },
      },
    }
  end

  if not lvim.format_on_save then
    vim.cmd [[
      if exists('#autoformat#BufWritePre')
        :autocmd! autoformat
      endif
    ]]
  end
end

function utils.reload_lv_config()
  vim.cmd "source ~/.config/nvim/lua/settings.lua"
  vim.cmd "source ~/.config/nvim/lua/plugins.lua"
  --[[ local plugins = require "plugins"
  local plugin_loader = require("plugin-loader").init()
  utils.toggle_autoformat()
  plugin_loader:load { plugins, lvim.plugins } ]]
  vim.cmd ":PackerCompile"
  vim.cmd ":PackerInstall"
  require("keymappings").setup()
  -- vim.cmd ":PackerClean"
end

function utils.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

function utils.get_active_client_by_ft(filetype)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == lvim.lang[filetype].lsp.provider then
      return client
    end
  end
  return nil
end

-- TODO: consider porting this logic to null-ls instead
function utils.get_supported_linters_by_filetype(filetype)
  local null_ls = require "null-ls"
  local matches = {}
  for _, provider in pairs(null_ls.builtins.diagnostics) do
    if vim.tbl_contains(provider.filetypes, filetype) then
      local provider_name = provider.name

      table.insert(matches, provider_name)
    end
  end

  return matches
end

function utils.get_supported_formatters_by_filetype(filetype)
  local null_ls = require "null-ls"
  local matches = {}
  for _, provider in pairs(null_ls.builtins.formatting) do
    if provider.filetypes and vim.tbl_contains(provider.filetypes, filetype) then
      -- table.insert(matches, { provider.name, ft })
      table.insert(matches, provider.name)
    end
  end

  return matches
end

function utils.unrequire(m)
  package.loaded[m] = nil
  _G[m] = nil
end

function utils.gsub_args(args)
  if args == nil or type(args) ~= "table" then
    return args
  end
  local buffer_filepath = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
  for i = 1, #args do
    args[i] = string.gsub(args[i], "${FILEPATH}", buffer_filepath)
  end
  return args
end

function utils.lvim_log(msg)
  if lvim.debug then
    vim.notify(msg, vim.log.levels.DEBUG)
  end
end

return utils

-- TODO: find a new home for these autocommands
