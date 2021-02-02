source $HOME/.config/nvim/general/paths.vim
source $HOME/.config/nvim/general/plug.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

if exists('g:vscode')
    source $HOME/.config/nvim/general/vscode.vim
    source $HOME/.config/nvim/plug-config/wiki.vim
else
    source $HOME/.config/nvim/keys/coc-maps.vim
    " source $HOME/.config/nvim/keys/which-key.vim
    source $HOME/.config/nvim/plug-config/barbar.vim
    source $HOME/.config/nvim/plug-config/coc.vim
    source $HOME/.config/nvim/plug-config/fzf.vim
    source $HOME/.config/nvim/plug-config/git-utils.vim
    source $HOME/.config/nvim/plug-config/neoterm.vim
    source $HOME/.config/nvim/plug-config/nvimtree.vim
    source $HOME/.config/nvim/plug-config/lsp_cpp.vim
    source $HOME/.config/nvim/plug-config/quickscope.vim
    source $HOME/.config/nvim/plug-config/startify.vim
    source $HOME/.config/nvim/plug-config/wiki.vim
    source $HOME/.config/nvim/themes/lightline.vim
    

    
    " if you have vim >=8.0 or neovim >= 0.1.5
    if (has("termguicolors"))
     set termguicolors
    endif
    
    " Theme
    " let g:gruvbox_contrast_dark='hard'
    autocmd vimenter * ++nested colorscheme doom-one

endif

" https://vi.stackexchange.com/a/25107
augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver20-blinkon1
augroup END
