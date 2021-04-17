local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

return require('packer').startup(function(use)

    -- packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

  -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    -- lsp
    use { 'neovim/nvim-lspconfig' }
    use { 'glepnir/lspsaga.nvim' }

     use {
      'kabouzeid/nvim-lspinstall',
      requires = {'neovim/nvim-lspconfig'},
    }

    -- treesitter

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- brackets maps
    use 'tpope/vim-unimpaired'
    use 'romgrk/doom-one.vim'
    use 'kyazdani42/nvim-web-devicons'

    -- TMUX
    use 'RyanMillerC/better-vim-tmux-resizer'
    use 'christoomey/vim-tmux-navigator'

    use { 'hrsh7th/nvim-compe' }
    use { 'hrsh7th/vim-vsnip' }

    use 'kevinhwang91/nvim-bqf'

    -- which key?
    use {
        'AckslD/nvim-whichkey-setup.lua',
        requires = {'liuchengxu/vim-which-key'},
    }

   use {
	   'Famiu/feline.nvim',
	   requires = {'kyazdani42/nvim-web-devicons'},
   }


       -- tree (view files)
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}, -- for file icons
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    }

    -- LF
    use {
        'ptzz/lf.vim',
        requires = {'voldikss/vim-floaterm'},
    }

	use { 'romgrk/barbar.nvim' }
	use { 'glepnir/dashboard-nvim' }

	--comments
	use { 'terrortylor/nvim-comment' }

	--Git suppport
	use { 'lewis6991/gitsigns.nvim' }
    use {
		'TimUntersberger/neogit',
		requires = {'nvim-lua/plenary.nvim'},
	}

    use { 'chrisbra/Colorizer' }
	
  end
)

