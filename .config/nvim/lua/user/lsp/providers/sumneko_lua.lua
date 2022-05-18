local default_opts = {
  settings = {
    Lua = {
      formatting = { enable = false },
      telemetry = { enable = false },
      -- diagnostics = {
      --   enable = false,
      -- },
      workspace = {
        maxPreload = 1000,
        preloadFileSize = 1000,
      },
    },
  },
}

local lua_dev_loaded, lua_dev = pcall(require, "lua-dev")
if not lua_dev_loaded then
  return default_opts
end

local dev_opts = {
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    -- plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    plugins = { "plenary.nvim", "LuaSnip" },
  },
  lspconfig = default_opts,
}

return lua_dev.setup(dev_opts)
