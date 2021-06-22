local wk = require('which-key')
local opts = {
    mode = "n", -- normal mode
    buffer = nil, -- global mappings. specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local mappings = {
  Q =  {'<cmd>BufferClose<cr>', 'close buffer'},
  ['<tab>'] =  {'<cmd>BufferNext<cr>', 'jump to next buffer'},
  ['<s-tab>'] =  {'<cmd>BufferPrevious<cr>' , 'jump to prev buffer'},
  ['<leader>j'] = {'<cmd>BufferPick<cr>', 'magic buffer-picking mode'},
  ['<leader>q'] = {
    name = "+barbar",
    q = {'<cmd>BufferWipeout<cr>', 'wipeout buffer'},
    e = {'<cmd>BufferCloseAllButCurrent<cr>', 'close all but current buffer'},
    h = {'<cmd>BufferCloseBuffersLeft<cr>', 'close all buffers to the left'},
    l = {'<cmd>BufferCloseBuffersRight<cr>', 'close all BufferLines to the right'},
    d = {'<cmd>BufferOrderByDirectory<cr>', 'sort BufferLines automatically by directory'},
    L = {'<cmd>BufferOrderByLanguage<cr>', 'sort BufferLines automatically by language'},
  }
}



wk.register(mappings, opts)

