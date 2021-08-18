--require('plenary.profile').start("profile.log")

require "utils"
require "plugins"
require "settings"
require("autocmds").setup()
require("keymappings").setup()
require "core.treesitter"
require("lsp").setup()



-- require'plenary.profile'.stop()
--
--[[ lv_utils.add_keymap_normal_mode({noremap = true},
  {"<leader>G", "<cmd>lua require('lv_utils').get_lsp_caps()<cr>"}) ]]
