-- disable brackets to use rainbow instead
require"nvim-treesitter.highlight"
local hlmap = vim.treesitter.highlighter.hl_map
hlmap["punctuation.bracket"] = nil

require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {enable = true, additional_vim_regex_highlighting = true},
    indentation = {enable = true},
    folding = {enable = true},
    rainbow = {enable = true},
    tsawesome = {enable = true},
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                -- ['i,'] = "@parameter.inner",
                -- ['a,'] = "@parameter.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>Lc"] = "@class.inner",
                ["<leader>Lf"] = "@function.inner",
                ["<leader>L,"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>Hc"] = "@class.inner",
                ["<leader>Hf"] = "@function.inner",
                ["<leader>H,"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        -- lsp_interop = {
        --     enable = true,
        --     peek_definition_code = {
        --         ["gp"] = "@function.outer",
        --         ["gP"] = "@class.outer",
        --     },
        -- },
    },
}

vim.cmd('autocmd TermOpen * TSBufDisable highlight')

local wk = require('whichkey_setup')

local keymap = {
    H = {
        name = '+swap⬅',
        c = 'class',
        f = 'function',
        [','] = 'parameter',
    },
    L = {
        name = '+swap➡',
        c = 'class',
        f = 'function',
        [','] = 'parameter',
    },
}

wk.register_keymap('leader', keymap)
