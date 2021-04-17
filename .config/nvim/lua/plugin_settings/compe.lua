-- TODO handle better?
vim.cmd('set completeopt=menuone,noselect')
vim.cmd('set shortmess+=c')

require('compe').setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        -- enabled
        path = true,
        buffer = true,
        nvim_lsp = true,
        ultisnips = true,
        calc = true,
        spell = true,
        -- disabled
        vsnip = false,
        nvim_lua = false,
        tags = false,
        snippets_nvim = false,
        treesitter = false,
        omni = false,
    }
}

local opts = {silent = true, expr = true}
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', opts)
vim.api.nvim_set_keymap('i', '<CR>',      'compe#confirm("<CR>")', opts)
vim.api.nvim_set_keymap('i', '<C-e>',     'compe#close("<C-e>")', opts)
vim.api.nvim_set_keymap('i', '<C-f>',     'compe#scroll({ "delta": +4 })', opts)
vim.api.nvim_set_keymap('i', '<C-d>',     'compe#scroll({ "delta": -4 })', opts)
