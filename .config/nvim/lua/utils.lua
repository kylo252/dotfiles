local utils = {}

function utils.reload_plugins()
  utils.reset_cache()
  vim.cmd(string.format("source %q/lua/plugins.lua", vim.fn.stdpath "config"))
  local packer = require "packer"
  packer.sync()
end

function utils.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true, client
    end
  end
  return false
end

function utils.get_active_client()
  local clients = vim.lsp.buf_get_clients()
  for _, client in pairs(clients) do
    -- return the first valid client, this is fine for now
    if client.name ~= "efm" and client.name ~= "null-ls" then
      return client
    end
  end
  return nil
end

function utils.reload_package(m)
  local status
  if package.loaded[m] then
    status = true
  end
  package.loaded[m] = nil
  _G[m] = nil
  status, _ = pcall(require, m)
  return status
end

function utils.xdg_open_handler()
  if vim.fn.executable "xdg-open" ~= 1 then
    vim.notify("xdg-open was not found", vim.log.levels.WARN)
    return
  end
  os.execute("xdg-open " .. vim.fn.expand "<cWORD>")
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

function utils.is_file(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type == "file" or false
end

function utils.reset_cache()
  local packer_cache = vim.fn.stdpath "config" .. "/plugin/packer_compiled.lua"
  if utils.is_file(packer_cache) then
    vim.fn.delete(packer_cache)
    require("packer").compile()
  end
end

vim.cmd [[ command! PackerReCompile lua require('utils').reset_cache() ]]

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end

return utils
