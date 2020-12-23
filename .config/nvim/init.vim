source $HOME/.config/nvim/general/paths.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/general/plug.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/plug-config/quickscope.vim
if exists('g:vscode')
    source $HOME/.config/nvim/general/vscode.vim
else
    source $HOME/.config/nvim/keys/coc-maps.vim
    "source $HOME/.config/nvim/keys/which-key.vim
    source $HOME/.config/nvim/plug-config/merge.vim
    source $HOME/.config/nvim/plug-config/neoterm.vim
    " source $HOME/.config/nvim/plug-config/coc.vim
    source $HOME/.config/nvim/plug-config/fzf.vim
    source $HOME/.config/nvim/plug-config/barbar.vim
    source $HOME/.config/nvim/plug-config/startify.vim
    source $HOME/.config/nvim/themes/lightline.vim
    
    " c++ syntax highlighting
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    
    " If you have vim >=8.0 or Neovim >= 0.1.5
    if (has("termguicolors"))
     set termguicolors
    endif
    
    " Theme
    " let g:gruvbox_contrast_dark='hard'
    autocmd vimenter * ++nested colorscheme doom-one

" lsp specific config
lua << EOF
  local nvim_lsp = require('lspconfig')

  local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'diagnostic'.on_attach()
    require'completion'.on_attach()

    -- Mappings.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end

  local servers = {'bashls', 'diagnosticls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

endif
