vim.cmd('highlight link GitSignsAdd Title')
vim.cmd('highlight link GitSignsDelete WarningMsg')
vim.cmd('highlight link GitSignsChange ModeMsg')

require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│'},
        change       = {hl = 'GitSignsChange', text = '│'},
        delete       = {hl = 'GitSignsDelete', text = '_'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾'},
        changedelete = {hl = 'GitSignsChange', text = '~'},
    },
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,

        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

        -- Text objects
        ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
    },
}

local wk = require('which-key')
local keymap = {
    name = '+hunk',
    s = {'<Cmd>lua require("gitsigns").stage_hunk()<CR>', 'stage'},
    u = {'<Cmd>lua require("gitsigns").undo_stage_hunk()<CR>', 'unstage'},
    r = {'<Cmd>lua require("gitsigns").reset_hunk()<CR>', 'reset'},
    R = {'<Cmd>lua require("gitsigns").reset_buffer()<CR>', 'reset buffer'},
    p = {'<Cmd>lua require("gitsigns").preview_hunk()<CR>', 'preview'},
    b = {'<Cmd>lua require("gitsigns").blame_line()<CR>', 'blame'},
}

wk.register(keymap, { prefix = "<leader>g"})

require('neogit').setup()
