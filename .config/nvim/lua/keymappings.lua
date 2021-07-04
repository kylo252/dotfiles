local function set_keymap(mode, opts, keymaps)
  for _, keymap in ipairs(keymaps) do
    vim.api.nvim_set_keymap(mode, keymap[1], keymap[2], opts)
  end
end


vim.g.mapleader = ' '

-- normal {{{1
set_keymap('n', {noremap=true, silent=true}, {
  -- set leader key
  {'<Space>', '<NOP>' },

  -- Jump list
  {'[j', '<C-o>'},
  {']j', '<C-i>'},

  -- save file
  {'<C-c>', '<Esc>'},
  {'<C-s>', ':w<CR>'},

  -- Page down/up
  {'[d', '<PageUp>'},
  {']d', '<PageDown>'},

  -- Navigate buffers
  {'<Tab>', ':bnext<CR>'},
  {'<S-Tab>', ':bprevious<CR>'},

  -- no hl
  {'<Leader>h', ':set hlsearch!<CR>'},

})

-- visual {{{1
set_keymap('x', {noremap=true, silent=true}, {
  -- Allow pasting same thing many times
  {'p', '""p:let @"=@0<CR>'},

  -- better indent
  {'>', '<gv'},
  {'<', '>gv'},

  -- Visual mode pressing * or # searches for the current selection
  {'*', ':<C-u>lua require("funcs.search").visual_selection("/")<CR>/<C-r>=@/<CR><CR>'},
  {'#', ':<C-u>lua require("funcs.search").visual_selection("?")<CR>?<C-r>=@/<CR><CR>'},

  -- move selected line(s)
  {'K', ':move \'<-2<CR>gv-gv'},
  {'J', ':move \'>+1<CR>gv-gv'},

  -- Format in visual mode
  {'<leader>lf', '<cmd>Format<CR>'},

  {'<leader>lF', "<cmd>lua vim.lsp.buf.formatting()<CR>"}
})

-- insert {{{1
set_keymap('i', {noremap=true, silent=true}, {
  -- alternative esc
  {'<C-c>', '<Esc>'},
  {'jk', '<Esc>'},
  {'kj', '<Esc>'},

  -- save file
  {'<C-s>', ':w<CR>'},

    -- insert special carachters
  {'<C-b>', '<C-k>'},
})

-- terminal {{{1
set_keymap('t', {noremap=true, silent=true}, {
  -- escape in terminal
  {'<Esc>', [[<C-\><C-n>]]},
  {'<C-c>', '<Esc>'},
  {'jk', '<Esc>'},
  {'kj', '<Esc>'},
})

