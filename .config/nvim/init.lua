require('plugins')
require('globals')
require('utils')
vim.cmd('luafile ~/.config/nvim/quick-settings.lua')
require('autocmds')
require('settings')
require('keymappings')
require('colorscheme')
require('config')

-- Which Key (Hope to replace with Lua plugin someday)
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')

---- LSP
require('lsp')
require('lsp.clangd')
require('lsp.lua-ls')
require('lsp.bash-ls')
require('lsp.go-ls')
require('lsp.python-ls')
require('lsp.rust-ls')
require('lsp.json-ls')
require('lsp.yaml-ls')
require('lsp.vim-ls')
require('lsp.docker-ls')
require('lsp.efm-general-ls')
