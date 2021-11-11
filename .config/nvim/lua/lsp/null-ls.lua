local M = {}

function M.config()
  return {
    formatters = {
      lua = { exe = "stylua", args = {} },
      sh = { exe = "shfmt", args = { "-i", "2", "-ci" } },
    },
    linters = {
      lua = { exe = "luacheck", args = {} },
      sh = { exe = "shellcheck", args = {"--exclude=SC1091"} },
    },
  }
end

function M.list_registered_providers_names(filetype)
  local u = require "null-ls.utils"
  local c = require "null-ls.config"
  local registered = {}
  for method, source in pairs(c.get()._methods) do
    for name, filetypes in pairs(source) do
      if u.filetype_matches(filetypes, filetype) then
        registered[method] = registered[method] or {}
        table.insert(registered[method], name)
      end
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
  for _, provider in pairs(config.formatters) do
    local source = null_ls.builtins.formatting[provider.exe].with {
      extra_args = provider.args,
    }
    table.insert(sources, source)
  end

  for _, provider in pairs(config.linters) do
    local source = null_ls.builtins.diagnostics[provider.exe].with {
      extra_args = provider.args,
    }
    table.insert(sources, source)
  end
  null_ls.config { sources = sources }

  require("lspconfig")["null-ls"].setup {}
end

return M
