require "user.utils"
require "user.plugins"
require "user.settings"
require("user.autocmds").setup()
require("user.keymappings").setup()
require "core.treesitter"

pcall(require, "scratch")

require("user.impatient").setup {
  path = vim.fn.stdpath "cache" .. "/lua_cache",
  enable_profiling = false,
}
