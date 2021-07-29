--require('plenary.profile').start("profile.log")

require "utils"
require "default-config"
require "plugins"
require "settings"
require "autocmds"
require "keymappings"
require "core.treesitter"
require "lsp"

-- require'plenary.profile'.stop()
--
--[[ lv_utils.add_keymap_normal_mode({noremap = true},
  {"<leader>G", "<cmd>lua require('lv_utils').get_lsp_caps()<cr>"}) ]]
