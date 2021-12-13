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

M.mappings = {
  ["<Space>"] = { "<c-^>", "Go to the alternate buffer" },
  b = {
    name = "+barbar",
    b = { "<cmd>Telescope buffers theme=get_ivy<CR>", "buffers" },
    q = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
    e = { "<cmd>BufferCloseAllButCurrent<cr>", "close all but current buffer" },
    h = { "<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left" },
    l = { "<cmd>BufferCloseBuffersRight<cr>", "close all BufferLines to the right" },
    d = { "<cmd>BufferOrderByDirectory<cr>", "sort BufferLines automatically by directory" },
    L = { "<cmd>BufferOrderByLanguage<cr>", "sort BufferLines automatically by language" },
    y = { "<cmd>lua require('utils').copy_help_url()<cr>", "copy help URL" },
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
    d = { "<cmd>lua require('core.telescope.custom-finders').find_dotfiles()<CR>", "Find dotfiles" },
    g = { "<cmd>lua require('core.telescope.custom-finders').grep_dotfiles()<CR>", "Find dotfiles" },
  },
  e = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },
  f = {
    name = "+Find",
    b = { "<cmd>Telescope current_buffer_fuzzy_find theme=get_ivy<CR>", "Current buffer fuzzy-find" },
    f = { "<cmd>Telescope find_files<CR>", "Find Files" },
    g = { "<cmd>lua require('core.telescope.custom-finders').grep_string_v2()<CR>", "grep string v2" },
    h = { "<cmd>Telescope help_tags<CR>", "help tags" },
    j = { "<cmd>Telescope zoxide list theme=get_ivy<CR>", "Zoxide" },
    l = { "<cmd>lua require('core.telescope.custom-finders').chained_live_grep()<CR>", "ChainedLiveGrep" },
    m = { "<cmd>Telescope marks theme=get_ivy<CR>", "Marks" },
    p = { "<cmd>Telescope git_files<CR>", "Find Project Files" },
    r = { "<cmd>Telescope oldfiles cwd_only=true theme=get_ivy<CR>", "Find recent files (local)" },
    i = {
      name = "+internal",
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
    J = { "<cmd>lua require('core.telescope.custom-finders').find_runtime_files()<CR>", "Find runtime files" },
    L = {
      "<cmd>lua require('core.telescope.custom-finders').local_buffer_fuzzy_grep()<CR>",
      "Local fuzzy grep",
    },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    R = { "<cmd>Telescope oldfiles theme=get_ivy<CR>", "Find recent files" },
  },
  g = {
    name = "+git",
    b = { "<cmd>Telescope git_bcommits theme=get_ivy<cr>", "Buffers commits" },
    c = {
      b = {
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard })<cr>',
        "Copy buffer URL",
      },
    },
    d = {
      [[<cmd>lua require('core.terminal').execute_command({bin = "lazygit", args = { "--git-dir=$HOME/.dtf.git", "--work-tree=$HOME" } })<CR>]],
      "LazyDots",
    },
    g = { [[<cmd>lua require('core.terminal').toggle_lazygit()<CR>]], "LazyGit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    S = { "<cmd>Telescope git_status theme=get_ivy<cr>", "Git status" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  },
  j = { "<cmd>BufferPick<cr>", "magic buffer-picking mode" },
  h = { "<cmd>nohlsearch<CR>", "No Highlight" },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    c = { "<cmd>lua require('lsp').get_client_capabilities()<cr>", "Show language-server capabilities" },
    d = {
      "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>",
      "Buffer Diagnostics",
    },
    w = {
      "<cmd>Telescope diagnostics<cr>",
      "Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<cr>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    Q = { "<cmd>Telescope quickfix<cr>", "Quickfix (Telescope)" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd> Telescope lsp_document_symbols theme=get_ivy<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols theme=get_ivy<cr>",
      "Workspace Symbols",
    },
  },
  L = {
    l = {
      name = "+logs",
      d = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
      i = { "<cmd>LspInstallLog<cr>", "Open lsp-installer logfile" },
      l = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
      n = { "<cmd>NullLsLog<cr>", "Open null-ls logfile" },
      p = { "<cmd>exe 'edit '.stdpath('cache').'/packer.nvim.log'<cr>", "Open the Packer logfile" },
    },
  },
  q = {
    name = "+quickfix",
    t = { "<cmd>BqfToggle<cr>", "toggle bqf" },
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
    a = { "<cmd>lua require_clean('scratch').test1()<cr>", "scratch test1" },
    s = { "<cmd>lua require_clean('scratch').test2()<cr>", "scratch test2" },
    e = { "<cmd>edit ~/.config/nvim/lua/scratch.lua<cr>", "edit scratch file" },
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
          v = false,
          d = false,
        },
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
  }

  local select_labels = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ac"] = "@class.outer",
    ["ic"] = "@class.inner",
    ["ar"] = "@parameter.inner", -- "ap" is already used
    ["ir"] = "@parameter.outer", -- "ip" is already used
    ["."] = "textsubjects-smart",
    [";"] = "textsubjects-big",
    ["iF"] = "(function_definition) @function",
  }

  local move_labels = {
    ["]m"] = "@function.outer",
    ["]]"] = "@class.outer",
    ["]M"] = "@function.outer",
    ["]["] = "@class.outer",
    ["[m"] = "@function.outer",
    ["[["] = "@class.outer",
    ["[M"] = "@function.outer",
    ["[]"] = "@class.outer",
  }
  wk.setup(setup_opts)

  wk.register(M.global_mappings)

  wk.register(M.mappings, { prefix = "<leader>" })

  wk.register(select_labels, { mode = "o", prefix = "", preset = true })
  wk.register(move_labels, { mode = "n", prefix = "", preset = true })
end

return M
