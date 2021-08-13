local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
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

--[[
FIXME: figure out why this is breaking barbar and indent-line and requires neovim restart
see [#401](https://github.com/wbthomason/packer.nvim/issues/401)
and [#201](https://github.com/wbthomason/packer.nvim/issues/201)
]]
-- vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

packer.startup(function(use)
  -- packer can manage itself as an optional plugin
  use { "wbthomason/packer.nvim" }
  use { "nvim-lua/plenary.nvim" }
  use { "tjdevries/astronauta.nvim" }
  use { "nvim-lua/popup.nvim" }

  -- LSP and linting
  use {
    { "nvim-treesitter/nvim-treesitter" },
    { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" },
    { "neovim/nvim-lspconfig" },
    { "kabouzeid/nvim-lspinstall", cmd = "LspInstall" },
    {
      "hrsh7th/nvim-compe",
      event = "InsertEnter *",
      config = [[require('core.compe')]],
      -- disable = true
    },
    {
      "b3nj5m1n/kommentary",
      event = "BufRead",
      config = function()
        require("kommentary.config").use_extended_mappings()
      end,
    },
  }

  -- Helpers
  use { "folke/which-key.nvim", config = [[require("core.whichkey").setup() ]] }
  use { "folke/lua-dev.nvim" }

  -- Search
  use {
    {
      "nvim-telescope/telescope.nvim",

      config = [[require('core.telescope').setup()]],
      -- cmd = "Telescope",
      event = "BufWinEnter",
    },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    { "jvgrootveld/telescope-zoxide" },
    {
      "ggandor/lightspeed.nvim",
      event = "BufRead",
      config = [[require('core.lightspeed')]],
    },
  }

  -- TMUX and session management
  use {
    {
      "aserowy/tmux.nvim",
      event = "BufRead",
      config = [[require('core.tmux')]],
    },
    { "andersevenrud/compe-tmux", event = "InsertEnter *" },
    {
      "folke/persistence.nvim",
      event = "BufReadPre",
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
    { "romgrk/barbar.nvim", requires = { "kyazdani42/nvim-web-devicons" } },
    {
      "kyazdani42/nvim-tree.lua",
      -- cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
      -- event = "BufWinEnter",
      config = [[require('core.nvimtree')]],
    },

    {
      "glepnir/galaxyline.nvim",
      event = "WinEnter",
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
      event = "BufRead",
      config = [[require('core.git')]],
    },
    {
      "glepnir/dashboard-nvim",
      -- temporarily until https://github.com/glepnir/dashboard-nvim/issues/63 is resolved
      -- "ChristianChiarulli/dashboard-nvim",
      event = "BufWinEnter",
      cmd = { "Dashboard", "DashboardNewFile", "DashboardJumpMarks" },
      config = [[require('core.dashboard')]],
    },
  }

  -- utils
  use { "kevinhwang91/nvim-bqf", event = "BufRead" }

  -- misc
  -- https://github.com/neovim/neovim/issues/12587
  use {
    {
      "antoinemadec/FixCursorHold.nvim",
      event = "BufRead",
      config = function()
        vim.g.cursorhold_updatetime = 1000
      end,
    },
    { "chrisbra/Colorizer", cmd = "ColorToggle", opt = true },
  }
end)
