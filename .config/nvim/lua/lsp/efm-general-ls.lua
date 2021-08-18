local efm = {}

function efm.list_supported_provider_names(ft)
  if ft == "lua" then
    return { "stylua", "luacheck" }
  elseif ft == "sh" then
    return { "shellcheck", "shfmt" }
  else
    return { "efm" }
  end
end

function efm.generic_setup(ft)
  require("lspconfig").efm.setup {
    cmd = {
      DATA_PATH .. "/lspinstall/efm/efm-langserver",
    },
    init_options = { documentFormatting = true, codeAction = false, completion = false, documentSymbol = false },
    filetypes = ft,
    rootMarkers = { ".git/", "package.json" },
  }
end

return efm
