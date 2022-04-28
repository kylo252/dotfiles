require "user.utils"
require "user.plugins"
require "user.settings"
require("user.autocmds").setup()
require("user.keymappings").setup()
require "core.treesitter"

pcall(require, "scratch")
