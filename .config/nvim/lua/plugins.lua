local package_root = vim.fn.stdpath "data" .. "/site/pack"
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  vim.cmd "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end
packer.init {
  package_root = package_root,
  log = { level = "info" },
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
  use { "folke/lua-dev.nvim", filetype = "lua" }

  -- LSP and linting
  use {
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("core.treesitter").setup()
      end,
    },
    { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" },
    { "neovim/nvim-lspconfig" },
    { "jose-elias-alvarez/null-ls.nvim" },
    {
      "williamboman/nvim-lsp-installer",
    },
    {
      "hrsh7th/nvim-cmp",
      event = "BufRead",
      config = function()
        require("core.cmp").config()
      end,
    },
    { "L3MON4D3/LuaSnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
    { "andersevenrud/cmp-tmux", after = "nvim-cmp" },
    {
      "b3nj5m1n/kommentary",
      event = "BufWinEnter",
      config = [[ require("core.comment").setup() ]],
    },
  }

  -- Helpers
  use {
    "folke/which-key.nvim",
    config = function()
      require("core.whichkey").setup()
    end,
  }

  -- Search
  use {
    {
      "jvgrootveld/telescope-zoxide",
      requires = { "nvim-telescope/telescope.nvim" },
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
      run = "make",
    },
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("core.project").setup()
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      config = [[
        require('core.telescope').setup()
        require('core.telescope').setup_z()
        require("telescope").load_extension "fzf"
      ]],
      event = "BufEnter",
    },
    {
      "ggandor/lightspeed.nvim",
      event = "BufWinEnter",
      config = function()
        require("core.lightspeed").setup()
      end,
    },
  }

  -- TMUX and session management
  use {
    "aserowy/tmux.nvim",
    event = "VimEnter",
    config = function()
      require("core.tmux").setup()
    end,
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
      cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
      config = function()
        require("core.nvimtree").setup()
      end,
    },
    { "romgrk/barbar.nvim", requires = { "nvim-web-devicons" }, event = "BufWinEnter" },
    {
      "nvim-lualine/lualine.nvim",
      event = "BufWinEnter",
      config = function()
        require("core.statusline").setup()
      end,
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
      event = "BufRead",
      config = function()
        require("core.indent").setup()
      end,
    },

    {
      "goolord/alpha-nvim",
      event = "BufWinEnter",
      config = function()
        require("core.dashboard").setup()
      end,
    },
  }

  -- GIT
  use {
    {
      "lewis6991/gitsigns.nvim",
      event = "BufWinEnter",
      config = function()
        require("core.git").setup_gitsigns()
      end,
    },
    {
      "ruifm/gitlinker.nvim",
      event = "BufWinEnter",
      config = function()
        require("core.git").setup_gitlinker()
      end,
    },
  }

  -- utils
  use { "kevinhwang91/nvim-bqf", event = "BufRead", config = [[ require("core.quickfix").setup() ]] }
  use { "chrisbra/Colorizer", cmd = "ColorToggle", opt = true }
  use { "VebbNix/lf-vim" }
end)
