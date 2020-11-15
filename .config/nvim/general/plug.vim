" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin('~/.config/nvim/plugged')  

" Declare the list of plugins.

" Utils
"Plug 'preservim/nerdtree' "The NERDTree is a file system explorer for the Vim editor
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'samoshkin/vim-mergetool'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'liuchengxu/vim-which-key'
Plug 'morhetz/gruvbox'
Plug 'ptzz/lf.vim'
Plug 'rbgrouleff/bclose.vim'
" GIT
Plug 'tpope/vim-fugitive'

" cheat-sheet

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
