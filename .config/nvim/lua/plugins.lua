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
    git = {clone_timeout = 300},
    display = {
        open_fn = function()
            return require("packer.util").float {border = "single"}
        end
    }
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

  -- LSP and linting
  use {
    {"nvim-treesitter/nvim-treesitter"},
    {"nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead"},
    {"neovim/nvim-lspconfig"},
    {"kabouzeid/nvim-lspinstall", cmd = "LspInstall"},
    {
      "hrsh7th/nvim-compe",
      event = "InsertEnter *",
      config = [[require('core.compe')]],
      -- disable = true
    },
    {
      "mhartington/formatter.nvim",
      cmd = "Format",
      config = [[require('core.formatter')]],
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
  use { "folke/which-key.nvim" }

  -- Search
  use {
    {
      "folke/trouble.nvim",
      config = [[require('core.trouble')]],
      -- event = "BufWinEnter"
    },
    {
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "tjdevries/astronauta.nvim" },
      },
      config = [[require('core.telescope')]],
      -- cmd = "Telescope",
      event = "BufWinEnter",
      after = "trouble.nvim"
    },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    { "camspiers/snap", cmd = "Snap", config = [[require('core.snap')]] },
    {
      "ggandor/lightspeed.nvim",
      event = "BufRead",
      config = [[require('core.lightspeed')]],
    },
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = [[require('core.spectre')]],
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
      "rmagatti/auto-session",
      event = "BufWinEnter",
      -- event = "VimEnter",
      config = [[require('core.sessions')]],
    },
    {
      "rmagatti/session-lens",
      cmd = "Telescope",
      config = function()
        require("session-lens").setup()
      end,
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
      config = [[require('core.explorer')]],
    },

    {
      "ahmedkhalf/lsp-rooter.nvim", -- with this nvim-tree will follow you
      event = "BufRead",
      config = function()
        require("lsp-rooter").setup()
      end,
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
      event = "BufRead",
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
    }
  }

  -- utils
  use { "tpope/vim-unimpaired", event = "BufRead" }
  use { "kevinhwang91/nvim-bqf", event = "BufRead" }

  -- misc
  -- https://github.com/neovim/neovim/issues/12587
  use {
    {
      "antoinemadec/FixCursorHold.nvim",
      event = "BufRead",
      config = function()
        vim.g.cursorhold_updatetime = 1000
      end
    },
    {
      "gabrielpoca/replacer.nvim",
    },
    { "chrisbra/Colorizer", cmd = "ColorToggle", opt = true }
  }
end)
