local utils = require "user.utils"

local opts = {
  settings = {
    Lua = {
      telemetry = { enable = false },
      -- diagnostics = {
      --   enable = false,
      -- },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/site/pack/packer/start/LuaSnip"] = true,
          [vim.fn.stdpath "data" .. "/site/pack/packer/start/telescope.nvim"] = true,
        },
        maxPreload = 100,
        preloadFileSize = 1000,
      },
    },
  },
}

local awesome_lib = "/usr/share/awesome/lib"
if utils.is_directory(awesome_lib) then
  opts.settings.Lua.workspace.library[awesome_lib] = true
end

local lua_dev_loaded, lua_dev = pcall(require, "lua-dev")
if not lua_dev_loaded then
  return opts
end

local dev_opts = {
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    -- plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    plugins = { "plenary.nvim" },
  },
  lspconfig = opts,
}

return lua_dev.setup(dev_opts)
