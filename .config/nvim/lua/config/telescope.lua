local wk = require('which-key')

local opts = {silent=true, noremap=true}
vim.api.nvim_set_keymap('n', '<C-p>', '<Cmd>Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-f>', '<Cmd>Telescope live_grep<CR>', opts)

local keymap = {
    f = {
		name = '+Find',
		b = {'<Cmd>Telescope buffers<CR>', 'buffers'},
		h = {'<Cmd>Telescope help_tags<CR>', 'help tags'},
        c = {"<cmd>Telescope colorscheme<CR>", "Colorscheme"},
        f = {"<cmd>Telescope find_files<CR>", "Find File"},
        m = {"<cmd>Telescope marks<CR>", "Marks"},
        M = {"<cmd>Telescope man_pages<CR>", "Man Pages"},
        r = {"<cmd>Telescope oldfiles<CR>", "Open Recent File"},
        R = {"<cmd>Telescope registers<CR>", "Registers"},
        g = {"<cmd>Telescope live_grep<CR>", "Live Grep"},
    },
	c = {
        name = '+commands',
        c = {'<Cmd>Telescope commands<CR>', 'commands'},
        h = {'<Cmd>Telescope command_history<CR>', 'history'},
    },
    g = {
        name = '+git',
        g = {'<Cmd>Telescope git_commits<CR>', 'commits'},
        c = {'<Cmd>Telescope git_bcommits<CR>', 'bcommits'},
        b = {'<Cmd>Telescope git_branches<CR>', 'branches'},
        s = {'<Cmd>Telescope git_status<CR>', 'status'},
    },
}

wk.register(keymap, { prefix = "<leader>" })


local actions = require('telescope.actions')
-- Global remapping
------------------------------
-- '--color=never',
require('telescope').setup {
    defaults = {
        find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
        vimgrep_arguments = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
        prompt_position = "top",
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_defaults = {horizontal = {mirror = false}, vertical = {mirror = false}},
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,
                ["<esc>"] = actions.close,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- ["<C-i>"] = my_cool_custom_action,
            }
        }
    }
}
