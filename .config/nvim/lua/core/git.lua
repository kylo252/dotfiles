-- vim.cmd('highlight link GitSignsAdd Title')
-- vim.cmd('highlight link GitSignsDelete WarningMsg')
-- vim.cmd('highlight link GitSignsChange ModeMsg')
require("gitsigns").setup {  
  signs = {
    add = { hl = "GitSignsAdd", text = "│" },
    change = { hl = "GitSignsChange", text = "│" },
    delete = { hl = "GitSignsDelete", text = "_" },
    topdelete = { hl = "GitSignsDelete", text = "‾" },
    changedelete = { hl = "GitSignsChange", text = "~" },
  },
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
    ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

    -- Text objects
    ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
  },
}

-- require('neogit').setup()
