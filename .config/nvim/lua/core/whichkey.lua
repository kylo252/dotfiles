-- these are mostly the default values
local M = {}

M.mappings = {
  ["<Space>"] = { "<c-^>", "Go to the alternate buffer" },
  b = {
    name = "+buffers",
    b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
    f = { "<cmd>Telescope buffers<CR>", "buffers" },
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    H = { "<cmd>BufferLineMoveNext<cr>", "Move buffer to the left" },
    J = { "<cmd>BufferLineMovePrev<cr>", "Move buffer to the right" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
    D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
    L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
    y = { "<cmd>lua require('user.utils').copy_help_url()<cr>", "copy help URL" },
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
    d = {
      "<cmd>lua require('core.telescope.custom-finders').find_dotfiles()<CR>",
      "Find dotfiles",
    },
    g = {
      "<cmd>lua require('core.telescope.custom-finders').grep_dotfiles()<CR>",
      "Find dotfiles",
    },
  },
  e = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },
  f = {
    name = "+Find",
    b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current buffer fuzzy-find" },
    f = {
      "<cmd>lua require('core.telescope.custom-finders').find_project_files()<CR>",
      "Find files",
    },
    g = {
      "<cmd>lua require('core.telescope.custom-finders').grep_string_v2()<CR>",
      "grep string v2",
    },
    h = { "<cmd>Telescope help_tags<CR>", "help tags" },
    j = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
    l = { "<cmd>DynamicGrep<CR>", "DynamicGrep" },
    m = { "<cmd>Telescope marks<CR>", "Marks" },
    p = {
      "<cmd>lua require('core.telescope.custom-finders').find_files_local()<CR>",
      "Find files (local)",
    },
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
    J = { "<cmd>FindRuntimeFiles<CR>", "Find runtime files" },
    L = {
      "<cmd>lua require('core.telescope.custom-finders').local_buffer_fuzzy_grep()<CR>",
      "Local fuzzy grep",
    },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    P = { "<cmd>Telescope projects<CR>", "Find recent projects" },
    r = { "<cmd>Telescope oldfiles<CR>", "Find recent files" },
  },
  g = {
    name = "+git",
    a = { "<cmd>Telescope git_commits<cr>", "commits" },
    b = { "<cmd>Telescope git_bcommits<cr>", "Buffers commits" },
    -- d = { "LazyDots" },
    d = { "<cmd>! fman-tmux -c 'git dots-lazy'<cr>", "Lazygit" },
    -- g = { "LazyGit" },
    g = { "<cmd>! fman-tmux -c lazygit<cr>", "Lazygit" },
    S = { "<cmd>Telescope git_status<cr>", "Git status" },
  },
  j = { "<cmd>BufferLinePick<cr>", "magic buffer-picking mode" },
  h = { "<cmd>nohlsearch<CR>", "No Highlight" },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    c = {
      "<cmd>lua require('user.lsp.utils').get_client_capabilities()<cr>",
      "Show language-server capabilities",
    },
    d = {
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      "Buffer Diagnostics",
    },
    w = {
      "<cmd>Telescope diagnostics<cr>",
      "Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Mason info" },
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
    s = { "<cmd> Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  L = {
    l = {
      name = "+logs",
      d = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
      i = { "<cmd>LspInstallLog<cr>", "Open lsp-installer logfile" },
      l = {
        "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>",
        "Open the LSP logfile",
      },
      n = { "<cmd>NullLsLog<cr>", "Open null-ls logfile" },
      p = {
        "<cmd>exe 'edit '.stdpath('cache').'/packer.nvim.log'<cr>",
        "Open the Packer logfile",
      },
    },
  },
  q = {
    name = "+quickfix",
    t = { "<cmd>BqfToggle<cr>", "toggle bqf" },
  },
  S = {
    name = "+sessions",
    l = { "<cmd>SessionLoad<cr>", "load session" },
    s = { "<cmd>SessionSave<cr>", "save session" },
  },
  t = {
    name = "+scratch test",
    a = { "<cmd>lua require_clean('scratch').test1()<cr>", "scratch test1" },
    s = { "<cmd>lua require_clean('scratch').test2()<cr>", "scratch test2" },
    e = { "<cmd>edit ~/.config/nvim/lua/scratch.lua<cr>", "edit scratch file" },
  },
  T = {
    name = "+TreeSitter",
    f = { ":TSNodeUnderCursor<cr>", "Node under cursor" },
    c = { ":TSCaptureUnderCursor<cr>", "Capture under Cursor" },
    i = { ":TSConfigInfo<cr>", "Config info" },
    t = { ":TSPlaygroundToggle<cr>", "Playground" },
    d = { "<cmd>lua require('neogen').generate()<cr>", "Neogen" },
  },
  z = {
    name = "+zettel",
    j = { "<cmd>ZkNotes<cr>", "notes" },
    n = { "<cmd>ZkNew<cr>", "new" },
    t = { "<cmd>ZkNewFromContentSelection<cr>", "new from selection" },
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
        windows = false, -- default bindings on <c-w> -- NOTE: broken on nvim v0.8 as of a3c19ec
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
    ["ak"] = "@comment.outer",
    ["ac"] = "@class.outer",
    ["ic"] = "@class.inner",
    ["aa"] = "@parameter.inner", -- "ap" is already used
    ["ia"] = "@parameter.outer", -- "ip" is already used
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
    ["]k"] = "@comment.outer",
    ["[k"] = "@comment.outer",
    ["]K"] = "@comment.outer",
    ["[K"] = "@comment.outer",
  }

  local lsp_ts_labels = {
    ["gpof"] = "@function.outer",
    ["gpoc"] = "@class.outer",
  }

  wk.setup(setup_opts)

  wk.register(M.mappings, { prefix = "<leader>" })

  wk.register(select_labels, { mode = "o", prefix = "", preset = true })
  wk.register(move_labels, { mode = "n", prefix = "", preset = true })
  wk.register(lsp_ts_labels, { mode = "n", prefix = "", preset = true })
end

return M
