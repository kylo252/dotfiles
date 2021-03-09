source $XDG_CONFIG_HOME/nvim/general/paths.vim
source $XDG_CONFIG_HOME/nvim/general/plug.vim
source $XDG_CONFIG_HOME/nvim/general/settings.vim
source $XDG_CONFIG_HOME/nvim/keys/mappings.vim

if exists('g:vscode')
    source $XDG_CONFIG_HOME/nvim/general/vscode.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/wiki.vim
else
    source $XDG_CONFIG_HOME/nvim/keys/coc-maps.vim
    source $XDG_CONFIG_HOME/nvim/keys/which-key.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/barbar.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/coc.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/fzf.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/git-utils.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/lsp_cpp.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/neoterm.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/lf.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/quickscope.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/startify.vim
    source $XDG_CONFIG_HOME/nvim/plug-config/wiki.vim
    source $XDG_CONFIG_HOME/nvim/themes/lightline.vim
    
    " Theme
    autocmd vimenter * ++nested colorscheme doom-one

endif


