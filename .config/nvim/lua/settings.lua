TERMINAL = vim.fn.expand('$TERMINAL')

-- temporary workaround until https://github.com/neovim/neovim/pull/13479 is finished

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2

vim.g.mapleader = ' '
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for

opt('o', 'clipboard', 'unnamedplus')                  -- Share system clipboard
opt('o', 'conceallevel', 0)
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'ignorecase', true)                          -- Ignore case with capitals
opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'mouse', 'a')																-- Enable mouse support for all modes
opt('o', 'scrolloff', 4 )                             -- Lines of context
opt('o', 'showmode', false)                           -- No need to show --insert--
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8 )                         -- Columns of context
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'updatetime', 300)														-- Faster completion
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'title', true)
opt('o', 'titlestring', "%<%F%=%l/%L - nvim")
opt('o', 'wildmode', 'longest:full,full')             -- Command-line completion mode

opt('w', 'list', true)                                -- Show some invisible characters (tabs...)
opt('w', 'number', true)                              -- Print line number
opt('w', 'relativenumber', true)                      -- Relative line numbers
opt('w', 'wrap', false)                               -- Disable line wrap

-- vim.o.pumheight = 10 -- Makes popup menu smaller
-- vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
-- vim.wo.cursorline = true -- Enable highlighting of the current line
--
vim.o.guifont = "Droid Sans Mono Nerd Font"
