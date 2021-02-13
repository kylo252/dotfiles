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
    " Plug 'neovim/nvim-lspconfig'
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    
    " layout and work-flow
    Plug 'kassio/neoterm'
    Plug 'romgrk/barbar.nvim' " <- better tabline
    Plug 'itchyny/lightline.vim'
    Plug 'mhinz/vim-startify'
    Plug 'kyazdani42/nvim-tree.lua'

    " utils
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'tomtom/tcomment_vim'
    Plug 'unblevable/quick-scope'
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-unimpaired'
    Plug 'vimwiki/vimwiki'
    Plug 'michal-h21/vim-zettel'
	
    " themes
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'romgrk/doom-one.vim'
    Plug 'ap/vim-css-color'

    " git
    Plug 'lambdalisue/gina.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'
    Plug 'rhysd/git-messenger.vim'
    " Plug 'tweekmonster/startuptime.vim'

endif 
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
