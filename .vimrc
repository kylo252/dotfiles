set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath+=$XDG_DATA_HOME/vim
set runtimepath+=$XDG_CONFIG_HOME/vim/after

set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after
set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim

let g:netrw_home = $XDG_DATA_HOME."/vim"
call mkdir($XDG_DATA_HOME."/vim/spell", 'p')

set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p')
set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p')
set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p')
set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p')

if !has('nvim') | set viminfofile=$XDG_STATE_HOME/vim/viminfo | endif

let g:c_syntax_for_h = 1

let g:netrw_home = $XDG_DATA_HOME . '/vim'

" set leader key
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing

" Settings {{{
set nocompatible
set autochdir                           " Your working directory will alway be the same as your working directory
set clipboard=unnamedplus               " Copy paste between vim and everything else
set cmdheight=2                         " More space for displaying messages
set conceallevel=0                      " So that I can see `` in markdown files
set expandtab                           " Converts tabs to spaces
set formatoptions-=cro                  " Stop newline continution of comments
set hidden                              " Required to keep multiple buffers open multiple buffers
set ignorecase
set incsearch
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set nobackup                            " This is recommended by coc
set novisualbell                        " I don't know why this on by default..
set nowrap                              " Display long lines as just one line
set nowritebackup                       " This is recommended by coc
set number relativenumber               " Line numbers
set pumheight=10                        " Makes popup menu smaller
set ruler                               " Show the cursor position all the time
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set showtabline=2                       " Always show tabs
set smartindent                         " Makes indenting smart
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set tabstop=2                           " Insert 2 spaces for a tab
set timeoutlen=1000                     " By default timeoutlen is 1000 ms
set updatetime=300                      " Faster completion
" }}}

" if you have vim >=8.0 or neovim >= 0.1.5
" if (has("termguicolors"))
"  set termguicolors
" endif

"" You can't stop me
cmap w!! w !sudo tee %

augroup myvimrc    
  au!
  au BufWritePost .vimrc ++nested so $MYVIMRC 
augroup END

if &term =~ '^xterm'
  " solid underscore
  let &t_SI .= "\<Esc>[5 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

" " https://vi.stackexchange.com/a/25107
augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver20-blinkon1
augroup END

" {{{ KEYBINDINGS
inoremap jj <esc>
inoremap jk <esc>

nnoremap <leader>h :noh<cr>
nnoremap <c-s> :w<cr>
" }}}
