CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')
TERMINAL = vim.fn.expand('$TERMINAL')

O = {
  lang = {
    python = {
      linter = '',
      -- @usage can be 'yapf', 'black'
      formatter = '',
      autoformat = false,
      isort = false,
      diagnostics = {
        virtual_text = {spacing = 0, prefix = ""},
        signs = true,
        underline = true
      },
      analysis = {
        type_checking = "basic",
        auto_search_paths = true,
        use_library_code_types = true
      }
    },
    lua = {
      -- @usage can be 'lua-format'
      formatter = '',
      autoformat = false,
      diagnostics = {
        virtual_text = {spacing = 0, prefix = ""},
        signs = true,
        underline = true
      }
    },
    sh = {
      -- @usage can be 'shellcheck'
      linter = '',
      -- @usage can be 'shfmt'
      formatter = '',
      autoformat = false,
      diagnostics = {
        virtual_text = {spacing = 0, prefix = ""},
        signs = true,
        underline = true
      }
    },
    json = {
      -- @usage can be 'prettier'
      formatter = '',
      autoformat = false,
      diagnostics = {
        virtual_text = {spacing = 0, prefix = ""},
        signs = true,
        underline = true
      }
    },
    clang = {
      diagnostics = {
        virtual_text = {spacing = 0, prefix = ""},
        signs = true,
        underline = true
      },
      cross_file_rename = true,
      header_insertion = 'never'
    },
    rust = {
      linter = '',
      formatter = '',
      autoformat = false,
      diagnostics = {
        virtual_text = {spacing = 0, prefix = ""},
        signs = true,
        underline = true
      }
    }

  }
}

-- TODO find a new home for these autocommands
require('utils').define_augroups({
  _general_settings = {
    {
      'TextYankPost',
      '*',
      'lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})'
    },
    {
      'BufWinEnter',
      '*',
      'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
    },
    {
      'BufRead',
      '*',
      'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
    },
    {
      'BufNewFile',
      '*',
      'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
    },
    {'VimLeavePre', '*', 'set title set titleold='},
    {'FileType', 'qf', 'set nobuflisted'}
  },
  _markdown = {
    {'FileType', 'markdown', 'setlocal wrap'},
    {'FileType', 'markdown', 'setlocal spell'}
  },
  _buffer_bindings = {
    {'FileType', 'floaterm', 'nnoremap <silent> <buffer> q :q<CR>'}
  }
})
