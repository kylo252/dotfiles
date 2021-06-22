require('config.formatter')
require('config.compe')
require('config.dashboard')
require('config.git')
require('config.statusline')
require('config.telescope')
require('config.tree')
require('config.treesitter')
require('config.whichkey')
require('config.snap')
require('config.spectre')
-- TODO: figure out if this is the one causing the slow down
require('config.trouble')
require('config.tmux')

require('nvim_comment').setup()
require('neoscroll').setup({respect_scrolloff = true})
vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'Q', ':BufferClose<CR>', {noremap = true, silent = true})

-- " better buffer management
-- nnoremap <Leader>q :BufferClose<CR>
-- nnoremap <Leader>qq :BufferWipeout<CR>
-- 
-- " Magic buffer-picking mode
-- nnoremap <Leader>j :BufferPick<CR>
-- 
-- " Sort automatically by...
-- nnoremap <Leader>bd :BufferOrderByDirectory<CR>
-- nnoremap <Leader>bl :BufferOrderByLanguage<CR>
-- 
-- " Move to previous/next
-- nnoremap <TAB> :BufferNext<CR>
-- nnoremap <S-TAB> :BufferPrevious<CR>
vim.g["indentLine_fileTypeExclude"] = 'dashboard'
