local utils = require "utils"

local opts = {
  settings = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = {
        enable = false,
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 10000,
        preloadFileSize = 1000,
      },
    },
  },
}

local awesome_lib = "/usr/share/awesome/lib"
if utils.is_directory(awesome_lib) then
  opts.settings.Lua.workspace.library[awesome_lib] = true
end

return opts
