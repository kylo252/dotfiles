require "utils"
require "plugins"
require "settings"
require("autocmds").setup()
require("keymappings").setup()
require "core.treesitter"

pcall(require, "scratch")

require("impatient").setup {
  path = vim.fn.stdpath "cache" .. "/lua_cache",
  enable_profiling = false,
}
