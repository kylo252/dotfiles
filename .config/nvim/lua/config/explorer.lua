local view = require'nvim-tree.view'

vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_ignore_ft = {'dashboard'}
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_quit_on_open = 0 -- this doesn't play well with barbar
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_width_allow_resize  = 1
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_update_cwd = 1
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

local _M = {}
_M.toggle_tree = function()
  if view.win_open() then
    require'nvim-tree'.close()
    require'bufferline.state'.set_offset(0)
  else
    require'bufferline.state'.set_offset(31, 'TreeExplorer')
    require'nvim-tree'.find_file(true)
  end

end

return _M


