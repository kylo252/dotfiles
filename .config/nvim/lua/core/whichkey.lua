-- these are mostly the default values
local M = {}

M.global_mappings = {
  Q = { "<cmd>BufferClose<cr>", "close buffer" },
  -- ["<tab>"] = { "<cmd>BufferNext<cr>", "jump to next buffer" },
  -- ["<s-tab>"] = { "<cmd>BufferPrevious<cr>", "jump to prev buffer" },
  ["<C-p>"] = { "<cmd>Telescope find_files<CR>", "Open project files" },
  ["<M-f>"] = { "<cmd>Telescope live_grep<CR>", "Grep project files" },
  ["<S-k>"] = { "<cmd>lua vim.lsp.buf.signature_help({focusable = false})<CR>", "Signature Help" },
  g = {
    -- LSP
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to decleration" },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Go to references" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
  },
}

M.mappings = {
  ["<Space>"] = { ":BufferNext<CR>", "Go to the next buffer" },
  ["h"] = { '<cmd>let @/=""<CR>', "No Highlight" },
  b = {
    name = "+barbar",
    j = { "<cmd>BufferPick<cr>", "magic buffer-picking mode" },
    q = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
    e = { "<cmd>BufferCloseAllButCurrent<cr>", "close all but current buffer" },
    h = { "<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left" },
    l = { "<cmd>BufferCloseBuffersRight<cr>", "close all BufferLines to the right" },
    d = { "<cmd>BufferOrderByDirectory<cr>", "sort BufferLines automatically by directory" },
    L = { "<cmd>BufferOrderByLanguage<cr>", "sort BufferLines automatically by language" },
  },
  e = { '<cmd>lua require"core.explorer".toggle_tree()<CR>', "Open nvim-tree" },
  E = { '<cmd>lua require"core.telescope".scope_browser()<CR>', "Open scope browser" },
  f = {
    name = "+Find",
    b = { "<cmd>Telescope buffers<CR>", "buffers" },
    h = { "<cmd>Telescope help_tags<CR>", "help tags" },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<CR>", "Find Files" },
    g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
    l = { "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={vim.fn.expand(\"%:p\")} }<cr>", "Local live-grep" },
    m = { "<cmd>Telescope marks<CR>", "Marks" },
    p = { "<cmd>Telescope git_files<CR>", "Find Project Files" },
    r = { "<cmd>Telescope oldfiles<CR>", "Find Recenct Files" },
    R = { '<Cmd>lua require"core.telescope".open_recent()<CR>', "Frecency" },
    ["'"] = { "<cmd>Telescope registers<CR>", "Registers" },
    d = {
      name = "+dotfiles",
      d = { '<cmd>lua require"core.telescope".find_dotfiles()<CR>', "Open dotfiles" },
      s = { "<cmd>edit ~/.config/nvim/lua/settings.lua<CR>", "Edit nvim settings" },
      p = { "<cmd>edit ~/.config/nvim/lua/plugins.lua<CR>", "Edit Packer plugins" },
    },
  },
  c = {
    name = "+commands",
    c = { "<cmd>Telescope commands<CR>", "commands" },
    h = { "<cmd>Telescope command_history<CR>", "history" },
  },

  g = {
    name = "+git",
    g = { "<cmd>Telescope git_commits<CR>", "commits" },

    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    B = { "<cmd>Telescope git_branches<CR>", "branches" },
    S = { "<cmd>Telescope git_status<CR>", "status" },
  },
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
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}})<cr>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}})<cr>",
      "Prev Diagnostic",
    },
    q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd> Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  t = {
    name = "+trouble",
    t = { "<cmd>Trouble<CR>", "toggle trouble" },
    w = { "<cmd>Trouble lsp_workspace_diagnostics<CR>", "toggle workspace diagnostics" },
    d = { "<cmd>Trouble lsp_document_diagnostics<CR>", "toggle document diagnostics" },
    l = { "<cmd>Trouble loclist<CR>", "toggle loclist" },
    r = { "<cmd>Trouble lsp_references<CR>", "toggle references" },
    q = { "<cmd>Trouble quickfix<CR>", "toggle quickfix" },
  },
  r = {
    name = "+replace",
    f = { "<cmd>lua require('replacer').run()<cr>", "Run replacer" },
  },
  S = {
    name = "+sessions",
    s = { "<cmd>lua require('session-lens').search_session()<cr>", "search sessions" },
  },
  P = {
    name = "+packer",
    s = { "<cmd>PackerSync<CR>", "Packer Sync" },
    c = { "<cmd>PackerCompile<CR>", "Packer Compile" },
    t = { "<cmd>PackerStatus<CR>", "Packer Status" },
    C = { "<cmd>PackerClean<CR>", "Packer Clean" },
    l = { "<cmd>PackerLoad<CR>", "Packer Load" },
  },
}

function M.setup()
  local wk = require "which-key"

  -- Set leader
  vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
  vim.g.mapleader = " "

  require("which-key").setup {
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
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
  }

  local global_opts = {
    mode = "n", -- normal mode
    buffer = nil, -- global mappings. specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  -- TODO: move all the mappings here
  local opts = vim.deepcopy(global_opts)
  opts.prefix = "<leader>"

  wk.register(M.mappings, opts)
  wk.register(M.global_mappings, global_opts)
end

return M
