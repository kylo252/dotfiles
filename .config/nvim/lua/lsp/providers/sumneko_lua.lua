local provider_root_path = vim.fn.stdpath "data" .. "/lspinstall/lua"

local provider_cmd = {
  provider_root_path .. "/sumneko-lua-language-server",
  "-E",
  provider_root_path .. "/main.lua",
}

local opts = {
  cmd = provider_cmd,
  root_dir = function(fname)
    return require("lspconfig/util").root_pattern(".git", "init.lua")(fname)
      or require("lspconfig/util").path.dirname(fname)
  end,
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "DATA_PATH" },
        disable = { "undefined-global" },
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

return opts
