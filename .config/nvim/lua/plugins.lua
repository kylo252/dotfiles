local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("git", "clone", "https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

packer.startup(function(use)
  -- packer can manage itself as an optional plugin
  use { "wbthomason/packer.nvim" }
  use { "nvim-lua/plenary.nvim" }
  use { "nvim-lua/popup.nvim", event = "BufWinEnter" }

  -- LSP and linting
  use {
    { "nvim-treesitter/nvim-treesitter", event = "BufRead", config = [[require("core.treesitter").setup()]] },
    { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" },
    { "neovim/nvim-lspconfig" },
    { "kabouzeid/nvim-lspinstall", cmd = "LspInstall" },
    {
      "hrsh7th/nvim-cmp",
      requires = {
        { "L3MON4D3/LuaSnip" },
      },
      event = "InsertEnter *",
      config = [[require('core.cmp').config()]],
    },
 { "hrsh7th/cmp-path", after = "nvim-cmp" },
 { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
 { "hrsh7th/cmp-nvim-lsp" },
    {
      "b3nj5m1n/kommentary",
      event = "BufWinEnter",
      config = [[ require("core.comment").setup() ]],
    },
  }

  -- Helpers
  use { "folke/which-key.nvim", config = [[require("core.whichkey").setup() ]] }
  use { "folke/lua-dev.nvim" }

  -- Search
  use {
    { "jvgrootveld/telescope-zoxide", event = "BufEnter" },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("core.project").setup()
      end,
      event = "BufEnter",
    },
    -- { "nvim-telescope/telescope-fzf-native.nvim", run = "make", event = "BufEnter" }, -- this is broken on Bionic
    {
      "nvim-telescope/telescope.nvim",
      config = [[require('core.telescope').setup()]],
      after = { "telescope-fzf-native.nvim", "telescope-zoxide" },
      event = "BufWinEnter",
    },
    {
      "ggandor/lightspeed.nvim",
      event = "BufWinEnter",
      config = [[require('core.lightspeed')]],
    },
  }

  -- TMUX and session management
  use {
    {
      "aserowy/tmux.nvim",
      event = "VimEnter",
      config = [[require('core.tmux')]],
    },
    { "andersevenrud/compe-tmux", event = "InsertEnter *" },
    {
      "folke/persistence.nvim",
      event = "VimEnter",
      config = [[require('core.sessions').setup()]],
    },
  }

  use {
    "akinsho/nvim-toggleterm.lua",
    event = "BufWinEnter",
    config = function()
      require("core.terminal").setup()
    end,
  }

  -- UI
  use {
    {
      "kylo252/onedark.nvim",
      config = function()
        require("onedark").setup()
      end,
    },
    {
      "kyazdani42/nvim-web-devicons",
    },
    {
      "kyazdani42/nvim-tree.lua",
      -- cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
      event = "BufWinEnter",
      config = [[require('core.nvimtree').setup()]],
    },
    { "romgrk/barbar.nvim", requires = { "nvim-web-devicons" }, event = "BufWinEnter" },
    {
      "glepnir/galaxyline.nvim",
      event = "BufWinEnter",
      config = [[require('core.statusline')]],
    },
    {
      "karb94/neoscroll.nvim",
      event = "BufRead",
      config = function()
        require("neoscroll").setup { respect_scrolloff = true }
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "VimEnter",
      config = [[require('core.indent')]],
    },
    {
      "lewis6991/gitsigns.nvim",
      event = "BufWinEnter",
      config = [[require('core.git')]],
    },
    {
      "glepnir/dashboard-nvim",
      event = "BufWinEnter",
      cmd = { "Dashboard", "DashboardNewFile", "DashboardJumpMarks" },
      config = [[require('core.dashboard')]],
    },
  }

  -- utils
  use { "kevinhwang91/nvim-bqf", event = "BufRead" }
  use { "chrisbra/Colorizer", cmd = "ColorToggle", opt = true }
  use { "VebbNix/lf-vim" }
end)
