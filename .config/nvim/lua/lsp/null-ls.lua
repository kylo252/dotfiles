local M = {}

function M.config()
  return {
    formatters = {
      lua = { exe = "stylua", args = {} },
      sh = { exe = "shfmt", args = { "-i", "2", "-ci", "-bn" } },
    },
    linters = {
      lua = { exe = "luacheck", args = {} },
      sh = { exe = "shellcheck", args = { "--exclude=SC1090,SC1091" } },
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
  null_ls.config { sources = sources, log = { level = "warn" } }

  local on_attach = function(client, bufnr)
    -- if client.resolved_capabilities.document_formatting then
    --   vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    -- end
  end
  require("lspconfig")["null-ls"].setup {
    on_attach = on_attach,
  }
end

return M
