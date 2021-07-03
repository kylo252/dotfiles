local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " ..
              install_path)
  execute "packadd packer.nvim"
end

--[[
FIXME: figure out why this is breaking barbar and indent-line and requires neovim restart
see [#401](https://github.com/wbthomason/packer.nvim/issues/401)
and [#201](https://github.com/wbthomason/packer.nvim/issues/201)
]]
execute "packadd packer.nvim"
execute "autocmd BufWritePost plugins.lua PackerCompile"

return require("packer").startup(function(use)

  -- packer can manage itself as an optional plugin
  use {"wbthomason/packer.nvim"}

  -- LSP and linting
  use {
    {"neovim/nvim-lspconfig"},
    {"glepnir/lspsaga.nvim", event = "BufRead"},
    {"kabouzeid/nvim-lspinstall", cmd = "LspInstall"},
    {
      "hrsh7th/nvim-compe",
      event = "InsertEnter *",
      config = [[require('config.compe')]]
    },
    {
      "mhartington/formatter.nvim",
      cmd = "Format",
      config = [[require('config.formatter')]]
    },
    {"nvim-treesitter/nvim-treesitter"},
    {
      "b3nj5m1n/kommentary",
      event = "BufRead",
      config = function()
        require('kommentary.config').use_extended_mappings()
      end
    }
  }

  -- Helpers
  -- use {"folke/which-key.nvim", config = [[require('config.whichkey')]]}
  use {"folke/which-key.nvim"}
  use {"nvim-lua/popup.nvim"}
  use {"nvim-lua/plenary.nvim"}

  -- Search
  use {
    {
      "folke/trouble.nvim",
      config = [[require('config.trouble')]],
      after = "dashboard-nvim",
      event = "BufRead"
    },
    {
      "nvim-telescope/telescope.nvim",
      config = [[require('config.telescope')]],
      cmd = "Telescope"
    },
    {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
    {"camspiers/snap", cmd = "Snap", config = [[require('config.snap')]]},
    {
      "ggandor/lightspeed.nvim",
      event = "BufRead",
      config = [[require('config.lightspeed')]]
    },
    {
      "windwp/nvim-spectre",
      event = "BufWinEnter",
      config = [[require('config.spectre')]]
    }
  }

  -- TMUX and session management
  use {
    {
      "aserowy/tmux.nvim",
      event = "BufRead",
      config = [[require('config.tmux')]]
    },
    {"andersevenrud/compe-tmux", event = "InsertEnter *"},
    {
      "rmagatti/auto-session",
      cmd = {"SaveSession", "RestoreSession", "DeleteSession"},
      event = "BufRead"
    },
    {
      "rmagatti/session-lens",
      cmd = {"SaveSession", "RestoreSession", "DeleteSession"},
      event = "BufRead",
      config = function()
        require('session-lens').setup({ --[[your custom config--]] })
      end
    }
  }

  -- UI
  use {
    {
      "kylo252/onedark.nvim",
      config = function()
        require('onedark').setup()
      end
    },
    {"romgrk/barbar.nvim", event = "BufRead"},
    {"kyazdani42/nvim-web-devicons"},
    {
      "kyazdani42/nvim-tree.lua",
      cmd = {"NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile"},
      event = "BufWinEnter",
      after = "barbar.nvim",
      config = [[require('config.explorer')]]
    },
    {
      "ahmedkhalf/lsp-rooter.nvim", -- with this nvim-tree will follow you
      event = "BufRead",
      config = function()
        require('lsp-rooter').setup()
      end
    },
    {
      "glepnir/galaxyline.nvim",
      event = "BufRead",
      config = [[require('config.statusline')]]
    },
    {
      "karb94/neoscroll.nvim",
      event = "BufRead",
      config = function()
        require('neoscroll').setup({respect_scrolloff = true})
      end
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = [[require('config.indent')]]
    },
    {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = [[require('config.git')]]
    },
    -- temporarily until https://github.com/glepnir/dashboard-nvim/issues/63 is resolved
    -- use { "glepnir/dashboard-nvim" }
    {
      "ChristianChiarulli/dashboard-nvim",
      event = 'BufWinEnter',
      cmd = {"Dashboard", "DashboardNewFile", "DashboardJumpMarks"},
      config = [[require('config.dashboard')]],
      opt = true
    }
  }

  -- utils
  use {"tpope/vim-unimpaired", event = "BufRead"}
  use {"kevinhwang91/nvim-bqf", event = "BufRead"}

  -- misc
  -- https://github.com/neovim/neovim/issues/12587
  use {
        "antoinemadec/FixCursorHold.nvim", 
        event = "BufRead",
        config =  function ()
	        vim.g.cursorhold_updatetime=1000
        end}
  use {"chrisbra/Colorizer", cmd = "ColorToggle", opt = true} -- hex colorizer
end)
