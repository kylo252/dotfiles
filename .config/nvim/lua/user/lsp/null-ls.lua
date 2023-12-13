local M = {}

local path = require("null-ls.utils").path
local root_pattern = require("null-ls.utils").root_pattern
local nls_cache = require("null-ls.helpers").cache

local py_cwd = function(params)
  local root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".flake8",
  }
  return root_pattern(unpack(root_files))(params.bufname)
end

function M.config()
  return {
    formatters = {
      { command = "black", extra_args = {}, filetypes = { "python" }, cwd = py_cwd },
      { command = "cmake-format" },
      { command = "isort", extra_args = {}, filetypes = { "python" }, cwd = py_cwd },
      { command = "stylua", extra_args = {}, filetypes = { "lua" } },
      { command = "shfmt", extra_args = { "-i", "2", "-ci", "-bn" }, filetypes = { "sh" } },
      {
        command = "uncrustify",
        filetypes = { "c" },
        extra_args = { "-q", "-l", "C", "-c", "src/uncrustify.cfg", "--no-backup" },
        cwd = nls_cache.by_bufnr(function(params)
          return root_pattern "src/uncrustify.cfg"(params.bufname)
        end),
        condition = function(utils)
          return utils.root_has_file "src/uncrustify.cfg"
        end,
      },
    },
    linters = {
      {
        command = "luacheck",
        extra_args = {},
        filetypes = { "lua" },
        -- cwd = nls_cache.by_bufnr(function(params) -- force luacheck to find its '.luacheckrc' file
        --   return root_pattern ".luacheckrc"(params.bufname)
        -- end),
        runtime_condition = nls_cache.by_bufnr(function(params)
          return path.exists(path.join(params.root, ".luacheckrc"))
        end),
      },
      -- { command = "flake8", extra_args = {}, filetypes = { "python" }, cwd = py_cwd },
    },
    code_actions = {
      -- { command = "proselint" },
    },
  }
end

function M.list_registered_providers_names(filetype)
  local s = require "null-ls.sources"
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

function M.list_registered_formatters(filetype)
  local null_ls_methods = require "null-ls.methods"
  local formatter_method = null_ls_methods.internal["FORMATTING"]
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[formatter_method] or {}
end

function M.list_registered_linters(filetype)
  local null_ls_methods = require "null-ls.methods"
  local linter_method = null_ls_methods.internal["DIAGNOSTICS"]
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[linter_method] or {}
end

function M.register_sources(configs, method)
  local null_ls = require "null-ls"

  local sources, registered_names = {}, {}

  for _, config in ipairs(configs) do
    local cmd = config.exe or config.command
    local name = config.name or cmd:gsub("-", "_")
    local type = method == null_ls.methods.CODE_ACTION and "code_actions"
      or null_ls.methods[method]:lower()
    local source = type and null_ls.builtins[type][name]
    if not source then
      vim.notify("Not a valid source: " .. name, vim.log.levels.ERROR)
    else
      local command = source._opts.command

      -- treat `args` as `extra_args` for backwards compatibility. Can otherwise use `generator_opts.args`
      local compat_opts = vim.deepcopy(config)
      if config.args then
        compat_opts.extra_args = config.args or config.extra_args
        compat_opts.args = nil
      end

      local opts = vim.tbl_deep_extend("keep", { command = command }, compat_opts)
      table.insert(sources, source.with(opts))
      vim.list_extend(registered_names, { source.name })
    end
  end

  if #sources > 0 then
    null_ls.register { sources = sources }
  end
  return registered_names
end

function M.setup()
  local config = M.config()

  local null_ls = require "null-ls"

  local default_opts = require("user.lsp").get_common_opts()
  local opts = vim.tbl_deep_extend("force", default_opts, { log = { level = "warn" } })
  null_ls.setup(opts)

  M.register_sources(config.formatters, null_ls.methods.FORMATTING)
  M.register_sources(config.linters, null_ls.methods.DIAGNOSTICS)
  M.register_sources(config.code_actions, null_ls.methods.CODE_ACTION)
end

return M
