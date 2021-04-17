local function set_keymap(mode, opts, keymaps)
    for _, keymap in ipairs(keymaps) do
        vim.api.nvim_set_keymap(mode, keymap[1], keymap[2], opts)
    end
end


vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- normal {{{1
set_keymap('n', {noremap=true, silent=true}, {
    -- remap leader keys to noop
    {' ', ''},
    {'\\', ''},

    -- execute q macro
    {'m', '@q'},

    -- save file
	{'<C-s>', ':w<CR>'},

    -- Jump list
    {'[j', '<C-o>'},
    {']j', '<C-i>'},

	 -- Resize split
    {'<C-w>+', ':resize +5<CR>'},
    {'<C-w>-', ':resize -5<CR>'},
    {'<C-w>+', ':vertical resize +5<CR>'},
    {'<C-w>-', ':vertical resize -5<CR>'},

    -- Page down/up
    {'[d', '<PageUp>'},
    {']d', '<PageDown>'},

    -- Navigate buffers
    {'<Tab>', ':bnext<CR>'},
    {'<S-Tab>', ':bprevious<CR>'},
    -- no hl
    {'<Leader>h', ':set hlsearch!<CR>'},

    -- explorer
    {'<Leader>e', ':NvimTreeToggle<CR>'},
    {'<Leader>f', ':Lf'},
})

-- visual {{{1
set_keymap('x', {noremap=true, silent=true}, {
    -- Allow pasting same thing many times
    {'p', '""p:let @"=@0<CR>'},

    -- better indent
    {'<', '<gv'},
    {'>', '>gv'},

    -- Visual mode pressing * or # searches for the current selection
    {'*', ':<C-u>lua require("funcs.search").visual_selection("/")<CR>/<C-r>=@/<CR><CR>'},
    {'#', ':<C-u>lua require("funcs.search").visual_selection("?")<CR>?<C-r>=@/<CR><CR>'},

    -- move selected line(s)
    {'K', ':move \'<-2<CR>gv-gv'},
    {'J', ':move \'>+1<CR>gv-gv'},
})

-- insert {{{1
set_keymap('i', {noremap=true, silent=true}, {
    -- Smart way to move between tabs
    {'<A-h>', [[<C-\><C-n>gT]]},
    {'<A-l>', [[<C-\><C-n>gt]]},

    -- alternative esc
    {'jk', '<Esc>'},

    -- insert special carachters
    {'<C-b>', '<C-k>'},
})

-- terminal {{{1
set_keymap('t', {noremap=true, silent=true}, {
    -- escape in terminal
    {'<Esc>', [[<C-\><C-n>]]},
    {'<A-[>', '<Esc>'},

    -- Smart way to move between windows
    {'<C-h>', [[<C-\><C-N><C-w>h]]},
    {'<C-j>', [[<C-\><C-N><C-w>j]]},
    {'<C-k>', [[<C-\><C-N><C-w>k]]},
    {'<C-l>', [[<C-\><C-N><C-w>l]]},

    -- Smart way to move between tabs
    {'<A-h>', [[<C-\><C-N>gT]]},
    {'<A-l>', [[<C-\><C-N>gt]]},
})

-- vim.api.nvim_set_keymap('i', '<C-TAB>', 'compe#complete()', {noremap = true, silent = true, expr = true})

-- vim.cmd([[
-- map p <Plug>(miniyank-autoput)
-- map P <Plug>(miniyank-autoPut)
-- map <leader>n <Plug>(miniyank-cycle)
-- map <leader>N <Plug>(miniyank-cycleback)
-- ]])
