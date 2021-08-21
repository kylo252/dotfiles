--require('plenary.profile').start("profile.log")

require "utils"
require "plugins"
require "settings"
require("autocmds").setup()
require("keymappings").setup()
require "core.treesitter"
require("lsp").setup()

pcall(require, "scratch")

-- require'plenary.profile'.stop()
