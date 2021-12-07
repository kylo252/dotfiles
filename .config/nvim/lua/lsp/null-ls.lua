local M = {}

function M.config()
  return {
    formatters = {
      { cmd = "stylua", args = {}, filetypes = { "lua" } },
      { cmd = "shfmt", args = { "-i", "2", "-ci", "-bn" }, filetypes = { "sh" } },
    },
    linters = {
      { cmd = "luacheck", args = {}, filetypes = { "lua" } },
      { cmd = "shellcheck", args = { "--exclude=SC1090,SC1091" }, filetypes = { "sh" } },
    },
    code_actions = {
      { cmd = "gitsigns", filetypes = {} },
      { cmd = "shellcheck", filetypes = {} },
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

function M:setup()
  local config = M.config()

  local null_ls = require "null-ls"
  local sources = {}
  for _, provider in ipairs(config.formatters) do
    local source = null_ls.builtins.formatting[provider.cmd].with {
      extra_args = provider.args,
    }
    table.insert(sources, source)
  end

  for _, provider in ipairs(config.linters) do
    local source = null_ls.builtins.diagnostics[provider.cmd].with {
      extra_args = provider.args,
    }
    table.insert(sources, source)
  end
  for _, provider in ipairs(config.code_actions) do
    local source = null_ls.builtins.code_actions[provider.cmd].with {}
    table.insert(sources, source)
  end
  null_ls.config { sources = sources, log = { level = "warn" } }
end

return M
