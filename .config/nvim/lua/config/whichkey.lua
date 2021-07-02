-- Disable some operators
local presets = require("which-key.plugins.presets")
presets.operators["v"] = nil
presets.operators["d"] = nil

-- these are mostly the default values
require("which-key").setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ...
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true -- bindings for prefixed with g
    }
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+" -- symbol prepended to a group
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
    padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = {min = 4, max = 25}, -- min and max height of the columns
    width = {min = 20, max = 50}, -- min and max width of the columns
    spacing = 3 -- spacing between columns
  },
  hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true -- show help message on the command line when the popup is visible
}

-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

local wk = require('which-key')
local global_opts = {
  mode = "n", -- normal mode
  buffer = nil, -- global mappings. specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false -- use `nowait` when creating keymaps
}

local opts = {
  prefix = "<leader>",
  mode = "n", -- normal mode
  buffer = nil, -- global mappings. specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false -- use `nowait` when creating keymaps
}

local global_mappings = {
  Q = {'<cmd>BufferClose<cr>', 'close buffer'},
  ['<tab>'] = {'<cmd>BufferNext<cr>', 'jump to next buffer'},
  ['<s-tab>'] = {'<cmd>BufferPrevious<cr>', 'jump to prev buffer'}
}

-- TODO: move all the mappings here
local mappings = {
  j = {'<cmd>BufferPick<cr>', 'magic buffer-picking mode'},
  l = {
    name = "LSP",
    a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
    A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
    d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
    D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
    f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"},
    h = {"<cmd>Lspsaga hover_doc<cr>", "Hover Doc"},
    i = {"<cmd>LspInfo<cr>", "Info"},
    l = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
    L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
    p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
    q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
    r = {"<cmd>Lspsaga rename<cr>", "Rename"},
    t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
    x = {"<cmd>cclose<cr>", "Close Quickfix"},
    s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
    S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"}
  },
  t = {
    name = '+trouble',
    t = {"<cmd>Trouble<CR>", "toggle trouble"},
    w = {"<cmd>Trouble lsp_workspace_diagnostics<CR>", "toggle workspace diagnostics"},
    d = {"<cmd>Trouble lsp_document_diagnostics<CR>", "toggle document diagnostics"},
    l = {"<cmd>Trouble loclist<CR>", "toggle loclist"},
    r = {"<cmd>Trouble lsp_references<CR>", "toggle references"},
    q = {"<cmd>Trouble quickfix<CR>", "toggle quickfix"}
  },
  q = {
    name = "+barbar",
    q = {'<cmd>BufferWipeout<cr>', 'wipeout buffer'},
    e = {'<cmd>BufferCloseAllButCurrent<cr>', 'close all but current buffer'},
    h = {'<cmd>BufferCloseBuffersLeft<cr>', 'close all buffers to the left'},
    l = {'<cmd>BufferCloseBuffersRight<cr>', 'close all BufferLines to the right'},
    d = {'<cmd>BufferOrderByDirectory<cr>', 'sort BufferLines automatically by directory'},
    L = {'<cmd>BufferOrderByLanguage<cr>', 'sort BufferLines automatically by language'}
  },
  s = {
    name = "+snap",
    g = {"<cmd>Snap live_grep<CR>", "grep"},
    f = {"<cmd>Snap find_files<CR>", "files"},
    s = {"<cmd>Snap oldfiles<CR>", "old files"},
    b = {"<cmd>Snap buffers<CR>", "buffers"}
  }
}

wk.register(global_mappings, global_opts)
wk.register(mappings, opts)
