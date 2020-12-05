
source $HOME/.config/nvim/general/paths.vim
source $HOME/.config/nvim/general/plug.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
if exists('g:vscode')
    source $HOME/.config/nvim/general/vscode.vim
else
    source $HOME/.config/nvim/keys/coc-maps.vim
    "source $HOME/.config/nvim/keys/which-key.vim
    source $HOME/.config/nvim/plug-config/merge.vim
    source $HOME/.config/nvim/plug-config/neoterm.vim
    source $HOME/.config/nvim/plug-config/coc.vim
    source $HOME/.config/nvim/plug-config/fzf.vim
    source $HOME/.config/nvim/plug-config/barbar.vim
    source $HOME/.config/nvim/themes/lightline.vim
    let NERDTreeShowHidden=1
    
    " c++ syntax highlighting
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    
    " If you have vim >=8.0 or Neovim >= 0.1.5
    if (has("termguicolors"))
     set termguicolors
    endif
    
    " Theme
    let g:gruvbox_contrast_dark='hard'
    autocmd vimenter * ++nested colorscheme gruvbox
endif
