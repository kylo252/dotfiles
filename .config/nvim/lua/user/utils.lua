local M = {}

function M.open_uri(uri)
  vim.notify("opening: " .. uri, vim.log.levels.INFO)
  local task = {
    command = "xdg-open",
    args = { uri },
  }
  local Job = require "plenary.job"
  Job:new(task):start()
end

function M.xdg_open_handler()
  if vim.fn.executable "xdg-open" ~= 1 then
    vim.notify("xdg-open was not found", vim.log.levels.WARN)
    return
  end

  local ts_utils = require "nvim-treesitter.ts_utils"
  local n = ts_utils.get_node_at_cursor()
  local uri = vim.treesitter.query.get_node_text(n, 0)
  M.open_uri(uri)
end

function M.copy_help_url()
  if vim.bo.filetype ~= "help" then
    return
  end
  local last_search_query = function()
    local history_string = vim.fn.execute "history :"
    local history_list = vim.split(history_string, "\n")
    for i = #history_list, 3, -1 do
      local item = history_list[i]
      local _, finish = string.find(item, "%d+ +")
      local hist_item = string.sub(item, finish + 1)
      local query = hist_item:match "h (%S+)"
      if query then
        return query
      end
    end
    return ""
  end

  local base_url = "https://neovim.io/doc/user/%s.html#%s"
  local help_url = string.format(base_url, vim.fn.expand "%:t:r", last_search_query())
  vim.notify(help_url, vim.log.levels.INFO, { title = "help url" })
  vim.fn.setreg("+", help_url)
  M.open_uri(help_url)
end

function M.gsub_args(args)
  if args == nil or type(args) ~= "table" then
    return args
  end
  local buffer_filepath = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
  for i = 1, #args do
    args[i] = string.gsub(args[i], "${FILEPATH}", buffer_filepath)
  end
  return args
end

function M.is_file(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type == "file" or false
end

function M.is_directory(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type == "directory" or false
end

function M.join_paths(...)
  local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

function M.on_dir_changed()
  local entry = vim.loop.cwd()
  local Job = require "plenary.job"
  local job = Job:new {
    command = "zoxide",
    args = { "add", entry },
  }
  job:start()
end

local function log_entry(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  local log = require("plenary.log").new {
    level = "info",
    plugin = "user_debug",
    info_level = 3,
    use_console = "sync",
  }
  log.info(unpack(objects))
  return ...
end

local function require_safe(m)
  local status_ok, module = pcall(require, m)
  if not status_ok then
    local trace = debug.getinfo(2, "SL")
    local shorter_src = trace.short_src:gsub(vim.fn.stdpath "config", ".")
    local lineinfo = shorter_src .. ":" .. (trace.currentline or trace.linedefined)
    local msg = string.format("%s : skipped loading [%s]", lineinfo, m)
    vim.notify_once(msg, vim.log.levels.TRACE)
  end
  return module
end

local function reload(m)
  local reloader = require_safe "plenary.reload"
  if reloader then
    reloader.reload_module(m, false)
  else
    package.loaded[m] = nil
  end
  return require_safe(m)
end

_G.reload = reload
_G.log_entry = log_entry
_G.P = vim.pretty_print
_G.dump = vim.pretty_print

return M
