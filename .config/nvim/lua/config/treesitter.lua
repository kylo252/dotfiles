-- avoid problems with old `gcc` on RHEL7
require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "lua" },
    highlight = { enable = true },
    -- indent = {enable = true, disable = {"python", "html", "javascript"}},
    indent = {enable = true},
    autotag = {enable = true},
    rainbow = {enable = false}
}
