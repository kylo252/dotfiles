require('config.barbar')
require('config.formatter')
require('config.comments')
require('config.compe')
require('config.dashboard')
require('config.git')
require('config.statusline')
require('config.telescope')
require('config.tree')
require('config.treesitter')
require('config.whichkey')
require('config.snap')

-- TODO: figure out if this is the one causing the slow down
require('config.trouble')

require('spectre').setup()
require('indent_guides').setup()
require('neoscroll').setup({respect_scrolloff = true})

require("tmux").setup({
  navigation = {
    -- cycles to opposite pane while navigating into the border
    cycle_navigation = true,

    -- enables default keybindings (C-hjkl) for normal mode
    enable_default_keybindings = true,

    -- prevents unzoom tmux when navigating beyond vim border
    persist_zoom = true
  },
  resize = {
    -- enables default keybindings (A-hjkl) for normal mode
    enable_default_keybindings = true
  }
})
