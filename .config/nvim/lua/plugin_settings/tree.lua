vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_ignore_ft = {'startify'}
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_width_allow_resize  = 1
vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
    }
}

local opts = {silent=true, noremap=true}
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

local wk = require('whichkey_setup')

local keymap = {
    name = '+navigation',
    f = {':NvimTreeFindFile<CR>', 'find file'},
}

wk.register_keymap('leader', {n = keymap})
