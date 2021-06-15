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
require('neoscroll').setup(
  {
    respect_scrolloff = true
})
