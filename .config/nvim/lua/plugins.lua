local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

return require('packer').startup(function(use)

    -- packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim' }

    -- LSP
    use { 'neovim/nvim-lspconfig' }
    use { 'glepnir/lspsaga.nvim' }
    use { 'kabouzeid/nvim-lspinstall',
		requires = {'neovim/nvim-lspconfig'} }
	use { 'folke/lsp-trouble.nvim' }

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate' }

    -- TMUX
    use { 'RyanMillerC/better-vim-tmux-resizer' }
    use { 'christoomey/vim-tmux-navigator' }
	use { 'tmux-plugins/vim-tmux-focus-events' }

    use { 'hrsh7th/nvim-compe' }
    use { 'hrsh7th/vim-vsnip' }
    use { 'kevinhwang91/nvim-bqf' }

    -- telescope
    use { 'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }

	-- UI
	use { 'glepnir/dashboard-nvim' }
    use { 'romgrk/doom-one.vim' }
	use { 'folke/tokyonight.nvim' }
	use { 'romgrk/barbar.nvim' } 	--tabs
    use { 'Famiu/feline.nvim', 		--statusline
		requires = {'kyazdani42/nvim-web-devicons'}}
    use { 'chrisbra/Colorizer' }    --hex colorizer

    -- file viewers (managers)
    use { 'kyazdani42/nvim-tree.lua',
		requires = {'kyazdani42/nvim-web-devicons'} }

	--Git suppport
	use { 'lewis6991/gitsigns.nvim' }
    use { 'TimUntersberger/neogit',
		requires = {'nvim-lua/plenary.nvim'} }

	-- utils
	use { 'terrortylor/nvim-comment' }
    use { 'tpope/vim-unimpaired' }
    use { 'folke/which-key.nvim' }
	use { 'windwp/nvim-spectre',
		requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim'} } }

	use { 'mhartington/formatter.nvim' }
  end
)

