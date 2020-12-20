" Bootstrap Plug
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin("$XDG_DATA_HOME/nvim/autoload/plugged")  

" sane defaults
" Plug 'sheerun/vimrc'

" Declare the list of plugins.
if exists('g:vscode')
    Plug 'machakann/vim-highlightedyank'
else
    " LSP
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    
    " layout and work-flow
    Plug 'kassio/neoterm'
    Plug 'moll/vim-bbye' " <- buffer management
    Plug 'romgrk/barbar.nvim' " <- better tabline
    Plug 'itchyny/lightline.vim'
    Plug 'mhinz/vim-startify'
    Plug 'justinmk/vim-dirvish'

    " utils
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'tomtom/tcomment_vim'
    Plug 'unblevable/quick-scope'

    " themes
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'romgrk/doom-one.vim'

    " nice to have
    Plug 'ap/vim-css-color'
    Plug 'lambdalisue/gina.vim'
    Plug 'tpope/vim-fugitive'
    " Plug 'tweekmonster/startuptime.vim'

endif 
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
