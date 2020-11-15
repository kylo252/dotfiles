
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/paths.vim
source $HOME/.config/nvim/general/plug.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/keys/coc-maps.vim
source $HOME/.config/nvim/keys/which-key.vim
source $HOME/.config/nvim/plug-config/merge.vim
source $HOME/.config/nvim/plug-config/neoterm.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/themes/airline.vim

autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let NERDTreeShowHidden=1
" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
" for LF
let g:lf_command_override = 'lf -command "set hidden"'

" Check file in shellcheck:
"	map <leader>s :ShellCheck! <CR>
"	map <leader>f :LShellCheck! <CR>
"    let g:shellcheck_qf_open = "botright copen 8"
"    let g:shellcheck_ll_open = "lopen 8"
