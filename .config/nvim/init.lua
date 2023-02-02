require "user.utils"
require "user.plugins".load()
require "user.settings"
require("user.autocmds").setup()
require("user.commands").setup()
require("user.keymaps").setup()
require "core.treesitter"

pcall(require, "scratch")
