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
Plug 'preservim/nerdtree' "The NERDTree is a file system explorer for the Vim editor
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'NLKNguyen/papercolor-theme'

" GIT
Plug 'tpope/vim-fugitive'

" cheat-sheet

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/paths.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/plug-config/neoterm.vim
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/syntastic.vim 
source $HOME/.config/nvim/themes/papercolor.vim
source $HOME/.config/nvim/themes/airline.vim

let NERDTreeShowHidden=1
autocmd! bufwritepost ~/.config/nvim/init.vim source $MYVIMRC

" Check file in shellcheck:
"	map <leader>s :ShellCheck! <CR>
"	map <leader>f :LShellCheck! <CR>
"    let g:shellcheck_qf_open = "botright copen 8"
"    let g:shellcheck_ll_open = "lopen 8"
