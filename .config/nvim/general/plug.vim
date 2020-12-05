" Bootstrap Plug
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin("$XDG_DATA_HOME/nvim/autoload/plugged")  

" Declare the list of plugins.
if exists('g:vscode')
    Plug 'machakann/vim-highlightedyank'
else
    " Utils
    Plug 'preservim/nerdtree' "The NERDTree is a file system explorer for the Vim editor
    Plug 'junegunn/fzf'
    "Plug 'junegunn/fzf.vim'
    Plug 'kassio/neoterm'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'liuchengxu/vim-which-key'
    Plug 'morhetz/gruvbox'
    "Plug 'ptzz/lf.vim'
    Plug 'ap/vim-css-color'
    " Better tabline
    Plug 'romgrk/barbar.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'itchyny/lightline.vim'
    Plug 'shinchu/lightline-gruvbox.vim'
    "Plug 'mengelbrecht/lightline-bufferline'
    Plug 'mhinz/vim-startify'
    Plug 'tweekmonster/startuptime.vim'
    " GIT
    Plug 'tpope/vim-fugitive'
    Plug 'lambdalisue/gina.vim'
    Plug 'tomtom/tcomment_vim'
    Plug 'moll/vim-bbye'
    Plug 'pearofducks/ansible-vim'
endif 
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
