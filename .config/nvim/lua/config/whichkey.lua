vim.g.which_key_fallback_to_native_key = 1
vim.g.which_key_display_names = {
    ['<CR>'] = '↵',
    ['<TAB>'] = '⇆',
}
vim.g.which_key_sep = '→'
vim.g.which_key_timeout = 100

require("whichkey_setup").config{
    hide_statusline = false,
    default_keymap_settings = {
        silent=true,
        noremap=true,
    },
    default_mode = 'n',
}
