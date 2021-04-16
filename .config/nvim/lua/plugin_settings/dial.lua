local opts = {silent = true, noremap=false}
vim.api.nvim_set_keymap('n', '<C-a>', '<Plug>(dial-increment)', opts)
vim.api.nvim_set_keymap('n', '<C-x>', '<Plug>(dial-decrement)', opts)
vim.api.nvim_set_keymap('v', '<C-a>', '<Plug>(dial-increment)', opts)
vim.api.nvim_set_keymap('v', '<C-x>', '<Plug>(dial-decrement)', opts)
vim.api.nvim_set_keymap('v', 'g<C-a>', '<Plug>(dial-increment-additional)', opts)
vim.api.nvim_set_keymap('v', 'g<C-x>', '<Plug>(dial-decrement-additional)', opts)
