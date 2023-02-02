local M = {}

local utils = require "user.utils"
local join_paths = utils.join_paths

local cache_dir = vim.fn.stdpath "cache"
local data_dir = vim.fn.stdpath "data"

local plugins_dir = join_paths(data_dir, "site", "pack", "lazy", "opt")

local lazy_install_dir = join_paths(plugins_dir, "lazy.nvim")

if not utils.is_directory(lazy_install_dir) then
  print "Initializing first time setup"
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazy_install_dir,
  }
end

vim.opt.runtimepath:append(lazy_install_dir)
vim.opt.runtimepath:append(join_paths(plugins_dir, "*"))

local lazy_cache = require "lazy.core.cache"
lazy_cache.setup {
  performance = {
    cache = {
      enabled = true,
      path = join_paths(cache_dir, "lazy", "cache"),
    },
  },
}

function M.load(specs)
  specs = specs or M.specs
  local lazy_available, lazy = pcall(require, "lazy")
  if not lazy_available then
    return
  end

  -- remove plugins from rtp before loading lazy, so that all plugins won't be loaded on startup
  vim.opt.runtimepath:remove(join_paths(plugins_dir, "*"))

  local status_ok = xpcall(function()
    local opts = {
      install = {
        missing = true,
        colorscheme = { "onedark", "habamax" },
      },
      ui = {
        border = "rounded",
      },
      root = plugins_dir,
      git = {
        timeout = 120,
      },
      lockfile = join_paths(cache_dir, "lazy-lock.json"),
      performance = {
        rtp = {
          reset = false,
        },
      },
      readme = {
        root = join_paths(cache_dir, "lazy", "readme"),
      },
    }

    lazy.setup(specs, opts)
  end, debug.traceback)

  if not status_ok then
    log_entry "problems detected while loading plugins' configurations"
  end
end

M.specs = {
  -- packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "folke/neodev.nvim", ft = "lua" },

  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      vim.schedule(function()
        require("nvim-treesitter.install").update()
      end)
    end,
    config = function()
      require("core.treesitter").setup()
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "nvim-treesitter/playground" },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("core.comment").setup()
    end,
  },

  -- LSP and linting
  { "neovim/nvim-lspconfig" },
  { "p00f/clangd_extensions.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    config = function()
      require("core.mason").setup()
    end,
  },
  { "tamago324/nlsp-settings.nvim" },
  { "b0o/schemastore.nvim" },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("core.cmp").config()
    end,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
      "cmp-tmux",
    },
  },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "andersevenrud/cmp-tmux", lazy = true },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load { paths = vim.fn.stdpath "config" .. "/luasnippets" }
    end,
  },
  -- Helpers
  {
    "folke/which-key.nvim",
    config = function()
      require("core.whichkey").setup()
    end,
    lazy = true,
  },

  -- Search
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("core.telescope").setup()
    end,
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  {
    "jvgrootveld/telescope-zoxide",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "make",
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("core.project").setup()
    end,
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufReadPost",
    config = function()
      require("core.lightspeed").setup()
    end,
  },

  -- TMUX and session management
  {
    "aserowy/tmux.nvim",
    event = "UIEnter",
    config = function()
      require("core.tmux").setup()
    end,
  },

  {
    "akinsho/nvim-toggleterm.lua",
    event = "BufReadPost",
    config = function()
      require("core.terminal").setup()
    end,
  },

  -- UI
  {
    "kylo252/onedark.nvim",
    config = function()
      require("onedark").setup {
        style = "darker",
      }
      vim.cmd [[colorscheme onedark]]
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    -- https://github.com/kyazdani42/nvim-tree.lua/issues/965
    -- cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
    init = function()
      vim.g.loaded = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require("core.nvimtree").setup()
    end,
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("core.bufferline").setup()
    end,
    event = "BufWinEnter",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("core.statusline").setup()
    end,
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  { "arkav/lualine-lsp-progress" },
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPost",
    config = function()
      require("neoscroll").setup {}
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
      require("core.indent").setup()
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("core.dashboard").setup()
    end,
  },

  -- GIT
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    config = function()
      require("core.git").setup_gitsigns()
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    event = "BufReadPost",
    config = function()
      require("core.git").setup_gitlinker()
    end,
  },

  -- utils
  { "gpanders/editorconfig.nvim" },
  {
    "kevinhwang91/nvim-bqf",
    event = "BufReadPost",
    config = function()
      require("core.quickfix").setup()
    end,
  },
  {
    "michaelb/sniprun",
    -- build = "bash ./install.sh",
    cmd = "SnipRun",
    config = function()
      require("core.sniprun").setup()
    end,
  },
  {
    "danymat/neogen",
    config = function()
      require("core.neogen").setup()
    end,
    cmd = "Neogen",
  },
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("core.zk").setup()
    end,
  },

  {
    "nvchad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup { ft = { "css", "scss", "html", "javascript" } }
    end,
  },
  { "VebbNix/lf-vim" },
}

return M
