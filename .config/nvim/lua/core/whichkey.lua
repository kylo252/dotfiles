-- these are mostly the default values
local M = {}

M.global_mappings = {
  ["<c-e>"] = { [[<cmd>lua require('core.terminal').toggle_explorer()<CR>]], "lf" },
  Q = { "<cmd>BufferClose<cr>", "close buffer" },
  g = {
    -- LSP
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to decleration" },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Go to references" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
  },
}

M.dashboard_mappings = {
  name = "dashboard",
  r = { "<cmd> Telescope oldfiles<cr>", "Recently Used Files" },
  f = { "<cmd> Telescope find_files hidden=true<cr>", "Find File" },
  p = { "<cmd> :edit ~/.config/nvim/lua/plugins.lua<cr>", "Plugins" },
  s = { "<cmd> :edit ~/.config/nvim/lua/settings.lua<cr>", "Settings" },
  g = { "<cmd> Telescope live_grep<cr>", "Find Word" },
  l = { "<cmd> SessionLoad<cr>", "Load Last Session" },
  m = { "<cmd> Telescope marks<cr>", "Marks" },
}

M.mappings = {
  ["<Space>"] = { ":BufferNext<CR>", "Go to the next buffer" },
  b = {
    name = "+barbar",
    q = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
    e = { "<cmd>BufferCloseAllButCurrent<cr>", "close all but current buffer" },
    h = { "<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left" },
    l = { "<cmd>BufferCloseBuffersRight<cr>", "close all BufferLines to the right" },
    d = { "<cmd>BufferOrderByDirectory<cr>", "sort BufferLines automatically by directory" },
    L = { "<cmd>BufferOrderByLanguage<cr>", "sort BufferLines automatically by language" },
  },
  c = {
    name = "+commands",
    r = { "<cmd>Telescope reloader<CR>", "Telescope reloader" },
    p = {
      name = "+packer",
      c = { "<cmd>lua require('utils').reset_cache()<CR>", "Packer Re-Compile" },
      l = { "<cmd>PackerLoad<CR>", "Packer Load" },
      r = { "<cmd>lua require('utils').reload_plugins()<cr>", "Reload plugins" },
      s = { "<cmd>PackerSync<CR>", "Packer Sync" },
      C = { "<cmd>PackerClean<CR>", "Packer Clean" },
      S = { "<cmd>PackerStatus<CR>", "Packer Status" },
    },
  },
  d = {
    name = "+dotfiles",
    d = { '<cmd>lua require("core.telescope").find_dotfiles()<CR>', "Find dotfiles" },
    g = { '<cmd>lua require("core.telescope").grep_dotfiles()<CR>', "Find dotfiles" },
  },
  e = { '<cmd>lua require("core.nvimtree").toggle_tree()<CR>', "Open scope browser" },
  E = { '<cmd>lua require("core.telescope").scope_browser()<CR>', "Open scope browser" },
  f = {
    name = "+Find",
    b = { "<cmd>Telescope buffers<CR>", "buffers" },
    d = { '<cmd>lua require("core.telescope").get_z_list()<CR>', "Zoxide" },
    f = { "<cmd>Telescope find_files<CR>", "Find Files" },
    g = { "<cmd>lua require'core.telescope'.live_grep_v2()<CR>", "Live Grep v2" },
    G = { "<cmd>lua require'core.telescope'.grep_string_v2()<CR>", "Grep String v2" },
    l = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
    p = { "<cmd>Telescope git_files<CR>", "Find Project Files" },
    r = { "<cmd>Telescope oldfiles<CR>", "Find Recenct Files" },
    h = { "<cmd>Telescope command_history<CR>", "history" },
    v = {
      name = "+vim",
      c = { "<cmd>Telescope commands<CR>", "commands" },
      h = { "<cmd>Telescope help_tags<CR>", "help tags" },
      m = { "<cmd>Telescope marks<CR>", "Marks" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      r = { "<cmd>Telescope registers<CR>", "Registers" },
      C = {
        "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    },
    L = {
      "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={vim.fn.expand(\"%:p\")} }<cr>",
      "Local live-grep",
    },
  },
  g = {
    name = "+git",
    c = {
      b = {
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard })<cr>',
        "Copy buffer URL",
      },
    },
    d = {
      [[<cmd>lua require('core.terminal').execute_command({bin = 'lazygit', args = { "--git-dir=$HOME/.dtf.git", "--work-tree=$HOME" } })<CR>]],
      "LazyDots",
    },
    g = { [[<cmd>lua require('core.terminal').toggle_lazygit()<CR>]], "LazyGit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  },
  j = { "<cmd>BufferPick<cr>", "magic buffer-picking mode" },
  h = { '<cmd>let @/=""<CR>', "No Highlight" },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    c = { "<cmd>lua require('lsp').get_ls_capabilities()<cr>", "Show language-server capabilities" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}})<cr>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}})<cr>",
      "Prev Diagnostic",
    },
    Q = { "<cmd>Telescope quickfix<cr>", "Quickfix (Telescope)" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd> Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  S = {
    name = "+sessions",
    d = { "<cmd>lua require('persistence').stop()<cr>", "stop saving" },
    l = { "<cmd>lua require('persistance').load()<cr>", "restore the session for the current directory" },
    r = { "<cmd>lua require('persistence').load({ last = true })<cr>)", "restore the last session" },
    s = { "<cmd>lua require('persistence').save()<cr>", "save session" },
  },
  t = {
    name = "+scratch test",
    ["1"] = { "<cmd>lua package.loaded['scratch'] = nil; require('scratch').test1()<cr>", "scratch test1" },
    ["2"] = { "<cmd>lua package.loaded['scratch'] = nil; require('scratch').test2()<cr>", "scratch test2" },
  },
}

function M.setup()
  local wk = require "which-key"

  -- Set leader
  vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
  vim.g.mapleader = " "
  local setup_opts = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = { -- adds help for operators like d, y, ...
        operators = {
          v = nil,
          d = nil,
        },
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
  }

  require("which-key").setup(setup_opts)

  wk.register(M.global_mappings)
  wk.register(M.dashboard_mappings, { prefix = "f", buffer = 1 })
  wk.register(M.mappings, { prefix = "<leader>" })
end

return M
