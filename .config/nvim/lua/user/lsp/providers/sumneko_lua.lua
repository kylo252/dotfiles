local xdg_data = os.getenv "XDG_DATA_HOME"

local ws_lib = {
  vim.fn.expand "$VIMRUNTIME",
}

local lua_dev_types = require("neodev.sumneko").types()
table.insert(ws_lib, lua_dev_types)
table.insert(ws_lib, xdg_data .. "/busted")

local add_package_path = function(package)
  local runtimedirs = vim.api.nvim__get_runtime({ "lua" }, true, { is_lua = true })
  for _, v in pairs(runtimedirs) do
    if v:match(package) then
      table.insert(ws_lib, v)
    end
  end
end

add_package_path "nvim%-treesitter"
add_package_path "lua%-dev"
add_package_path "plenary"
add_package_path "lspconfig"
add_package_path "mason"
add_package_path "mason%-lspconfig"

return {
  settings = {
    Lua = {
      formatting = { enable = false },
      telemetry = { enable = false },
      workspace = {
        library = ws_lib,
        maxPreload = 3000,
        preloadFileSize = 1000,
      },
    },
  },
}
