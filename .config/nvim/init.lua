require('plugins')
require('globals')
require('utils')

vim.cmd('source ~/.config/nvim/vimscript/functions.vim')

require('autocmds')
require('settings')
require('keymappings')
require('config')

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
