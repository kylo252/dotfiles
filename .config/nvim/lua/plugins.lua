local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
    -- packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim'}
    -- brackets maps
    use 'tpope/vim-unimpaired'
    use 'romgrk/doom-one.vim'
    use { 
      'kabouzeid/nvim-lspinstall', 
      requires = {'neovim/nvim-lspconfig'},
      config = 'require("plugin_settings.lspinstall")',
    }

    -- lsp
    use {
        'glepnir/lspsaga.nvim',
        requires = {'neovim/nvim-lspconfig'},
    }
    use {
        'hrsh7th/nvim-compe',
        config = 'require("plugin_settings.compe")',
    }
    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = 'vim.cmd(TSUpdate)',
        config = 'require("plugin_settings.treesitter")',
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    
    use 'kevinhwang91/nvim-bqf'

    -- which key?
    use {
        'AckslD/nvim-whichkey-setup.lua',
        requires = {'liuchengxu/vim-which-key'},
        config = 'require("plugin_settings.whichkey")',
    }

    -- Color
    use {
      'christianchiarulli/nvcode-color-schemes.vim',
    }
    -- comment with gcc
    use 'tpope/vim-commentary'
    
       -- tree (view files)
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}, -- for file icons
        config = 'require("plugin_settings.tree")',
    }
    
    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = 'require("plugin_settings.telescope")',
    }

    -- LF
    use {
      'ptzz/lf.vim', 
      requires = {'voldikss/vim-floaterm'},
    }

    use {
      'romgrk/barbar.nvim',
      config = 'require("plugin_settings.barbar")',
    }

    use {
      'glepnir/dashboard-nvim',
      config = 'require("plugin_settings.dashboard")'
    }

    -- TMUX
    use 'RyanMillerC/better-vim-tmux-resizer'
    use 'christoomey/vim-tmux-navigator'

end)
