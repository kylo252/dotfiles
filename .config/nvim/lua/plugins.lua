local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

return require("packer").startup(function(use)

  -- packer can manage itself as an optional plugin
  use {"wbthomason/packer.nvim"}

  -- https://github.com/neovim/neovim/issues/12587
  use {"antoinemadec/FixCursorHold.nvim"}

  -- LSP
  use {"neovim/nvim-lspconfig"}
  use {"glepnir/lspsaga.nvim"}
  use {"kabouzeid/nvim-lspinstall", requires = {"neovim/nvim-lspconfig"}}
  use {"folke/trouble.nvim"}

  -- treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

  -- TMUX
  use {"RyanMillerC/better-vim-tmux-resizer"}
  use {"christoomey/vim-tmux-navigator"}
  use {'andersevenrud/compe-tmux'}

  use {"hrsh7th/nvim-compe"}
  use {"hrsh7th/vim-vsnip"}
  use {"kevinhwang91/nvim-bqf"}

  -- telescope
  use {"nvim-telescope/telescope.nvim", requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}}
  use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
  use {"nvim-telescope/telescope-frecency.nvim", requires = {"tami5/sql.nvim"}}

  -- snap
  use { "camspiers/snap" }

  -- UI
  -- temporarily until https://github.com/glepnir/dashboard-nvim/issues/63 is resolved
  -- use { "glepnir/dashboard-nvim" }
  use {"ChristianChiarulli/dashboard-nvim"}
  use {'kylo252/onedark.nvim'}
  use {'folke/tokyonight.nvim'}

  use {"romgrk/barbar.nvim"} -- tabs
  use {"glepnir/galaxyline.nvim"}
  use {"chrisbra/Colorizer"} -- hex colorizer

  -- file viewers (managers)
  use {"kyazdani42/nvim-tree.lua", requires = {"kyazdani42/nvim-web-devicons"}}

  -- Git suppport
  use {"lewis6991/gitsigns.nvim"}
  use {"TimUntersberger/neogit", requires = {"nvim-lua/plenary.nvim"}}

  -- utils
  use {"terrortylor/nvim-comment"}
  use {"tpope/vim-unimpaired"}
  use {"folke/which-key.nvim"}
  use {"windwp/nvim-spectre", requires = {{"nvim-lua/plenary.nvim"}, {"nvim-lua/popup.nvim"}}}
  use {"junegunn/vim-easy-align"}
  use {"mhartington/formatter.nvim"}
  use {"glepnir/indent-guides.nvim"}
  use {"christoomey/vim-sort-motion"}
  use {"mg979/vim-visual-multi"}
end)
