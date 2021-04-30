local utils = require('utils')

local auto_formatters = {            }

local python_autoformat = {'BufWritePre', '*.py', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
if O.python.autoformat then table.insert(auto_formatters, python_autoformat) end

local lua_format = {'BufWritePre', '*.lua', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
if O.lua.autoformat then table.insert(auto_formatters, lua_format) end

local json_format = {'BufWritePre', '*.json', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
if O.json.autoformat then table.insert(auto_formatters, json_format) end

-- testing format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.sh,*.lua FormatWrite
augroup END
]], true)

utils.define_augroups({
    _general_settings = {
        {'TextYankPost', '*', 'lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})'},
        {'BufWinEnter', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        {'BufRead', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        {'BufNewFile', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        {'VimLeavePre', '*', 'set title set titleold='}

    },
    _dashboard = {
        -- seems to be nobuflisted that makes my stuff disapear will do more testing
        {
            'FileType', 'dashboard',
            'setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= '
        }, {'FileType', 'dashboard', 'set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2'}
    },
    _markdown = {{'FileType', 'markdown', 'setlocal wrap'}, {'FileType', 'markdown', 'setlocal spell'}},
    _buffer_bindings = {
        {'FileType', 'dashboard', 'nnoremap <silent> <buffer> q :q<CR>'},
        {'FileType', 'lspinfo', 'nnoremap <silent> <buffer> q :q<CR>'},
        {'FileType', 'floaterm', 'nnoremap <silent> <buffer> q :q<CR>'},
    },
    _auto_formatters = auto_formatters
})
