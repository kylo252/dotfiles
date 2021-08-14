-- these are mostly the default values
local M = {}

M.global_mappings = {
  ["<c-e>"] = { [[<cmd>lua require('core.terminal').execute_command({bin = 'lf'})<CR>]], "lf" },
  Q = { "<cmd>BufferClose<cr>", "close buffer" },
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
  h = { '<cmd>let @/=""<CR>', "No Highlight" },
  j = { "<cmd>BufferPick<cr>", "magic buffer-picking mode" },
  b = {
    name = "+barbar",
    q = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
    e = { "<cmd>BufferCloseAllButCurrent<cr>", "close all but current buffer" },
    h = { "<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left" },
    l = { "<cmd>BufferCloseBuffersRight<cr>", "close all BufferLines to the right" },
    d = { "<cmd>BufferOrderByDirectory<cr>", "sort BufferLines automatically by directory" },
    L = { "<cmd>BufferOrderByLanguage<cr>", "sort BufferLines automatically by language" },
  },
  e = { '<cmd>lua require"core.nvimtree".toggle_tree()<CR>', "Open nvim-tree" },
  d = {
    name = "+Directory (TODO)",
    d = { '<cmd>lua require("core.telescope").get_z_list()<CR>', "Zoxide" },
    e = { '<cmd>lua require("core.telescope").scope_browser()<CR>', "Open scope browser" },
  },
  f = {
    name = "+Find",
    b = { "<cmd>Telescope buffers<CR>", "buffers" },
    d = { '<cmd>lua require("core.telescope").find_dotfiles()<CR>', "Find dotfiles" },
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
    d = {
      [[<cmd>lua require('core.terminal').execute_command({bin = 'lazygit', args = { "--git-dir=$HOME/.dtf.git", "--work-tree=$HOME" } })<CR>]],
      "LazyDots",
    },
    g = { [[<cmd>lua require('core.terminal').execute_command({bin = 'lazygit'})<CR>]], "LazyGit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
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
    s = { "<cmd>lua require('persistence').save()<cr>", "stop saving" },
  },
  P = {
    name = "+packer",
    c = { "<cmd>PackerCompile<CR>", "Packer Compile" },
    l = { "<cmd>PackerLoad<CR>", "Packer Load" },
    r = { "<cmd>lua require('utils').reload_config()<cr>", "Reload config" },
    s = { "<cmd>PackerSync<CR>", "Packer Sync" },
    C = { "<cmd>PackerClean<CR>", "Packer Clean" },
    S = { "<cmd>PackerStatus<CR>", "Packer Status" },
  },
}

function M.setup()
  local wk = require("which-key")

  -- Set leader
  vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
  vim.g.mapleader = " "

  require("which-key").setup({
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
  })

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
