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
Plug 'samoshkin/vim-mergetool'
"Plug 'NLKNguyen/papercolor-theme'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'liuchengxu/vim-which-key'
Plug 'morhetz/gruvbox'
" GIT
Plug 'tpope/vim-fugitive'

" cheat-sheet

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
set shell=/usr/bin/bash
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/paths.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/keys/coc-maps.vim
source $HOME/.config/nvim/keys/which-key.vim
source $HOME/.config/nvim/plug-config/merge.vim
source $HOME/.config/nvim/plug-config/neoterm.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/fzf.vim
"source $HOME/.config/nvim/themes/papercolor.vim
source $HOME/.config/nvim/themes/airline.vim

autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let NERDTreeShowHidden=1
" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
" Check file in shellcheck:
"	map <leader>s :ShellCheck! <CR>
"	map <leader>f :LShellCheck! <CR>
"    let g:shellcheck_qf_open = "botright copen 8"
"    let g:shellcheck_ll_open = "lopen 8"
